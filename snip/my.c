/*
  +----------------------------------------------------------------------+
  | PHP Version 5                                                        |
  +----------------------------------------------------------------------+
  | Copyright (c) 1997-2015 The PHP Group                                |
  +----------------------------------------------------------------------+
  | This source file is subject to version 3.01 of the PHP license,      |
  | that is bundled with this package in the file LICENSE, and is        |
  | available through the world-wide-web at the following url:           |
  | http://www.php.net/license/3_01.txt                                  |
  | If you did not receive a copy of the PHP license and are unable to   |
  | obtain it through the world-wide-web, please send a note to          |
  | license@php.net so we can mail you a copy immediately.               |
  +----------------------------------------------------------------------+
  | Author:                                                              |
  +----------------------------------------------------------------------+
*/

/* $Id$ */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "php.h"
#include "php_ini.h"
#include "ext/standard/info.h"
#include "php_my.h"

#define MY_VERSION 0.1

static HashTable *my_ht;

#define PALLOC_HASHTABLE(ht)   do {                         \
	(ht) = (HashTable*)pemalloc(sizeof(HashTable), 1);    \
	if ((ht) == NULL) {                                     \
		zend_error(E_ERROR, "Cannot allocate HashTable, not enough memory?");  \
	}                                                       \
} while(0)

/* If you declare any globals in php_my.h uncomment this:
ZEND_DECLARE_MODULE_GLOBALS(my)
*/

/* True global resources - no need for thread safety here */
static int le_my;

/* {{{ PHP_INI
 */
PHP_INI_BEGIN()
    PHP_INI_ENTRY("my.global_value",      "42", PHP_INI_ALL, NULL)
    PHP_INI_ENTRY("my.global_string", "foobar", PHP_INI_ALL, NULL)
PHP_INI_END()
/* }}} */

PHP_FUNCTION(my_version) /* {{{ */
{
	RETVAL_DOUBLE(MY_VERSION);
}
/* }}} */

PHP_FUNCTION(my_var) /* {{{ */
{
	zval *fooval;

	MAKE_STD_ZVAL(fooval);
	ZVAL_STRING(fooval, "bar", 1);
	ZEND_SET_SYMBOL(&EG(symbol_table), "foo", fooval);
}
/* }}} */

PHP_FUNCTION(my_hash) /* {{{ */
{
	zval **zv_dest;

	if (zend_hash_index_find(my_ht, 42, (void **) &zv_dest) == SUCCESS) {
		/*char *s = Z_STRVAL_PP(zv_dest);*/
		/*RETVAL_STRING(s, 1);*/
		/*php_printf("ret: %s", *zv_dest);*/
		/*php_printf("ret: %s\n", Z_STRVAL_PP(zv_dest));*/
		/*zval *zv;*/
		/*ALLOC_ZVAL(zv);*/
		/*ZVAL_COPY_VALUE(zv, *zv_dest);*/
		/*RETURN_ZVAL_FAST(*zv_dest);*/
		ZVAL_COPY_VALUE(return_value, *zv_dest);
		zval_copy_ctor(return_value);
		/*efree(zv);*/
		/*ZVAL_COPY_VALUE(return_value, zv);*/
		/*RETVAL_STRING(Z_STRVAL_PP(zv_dest), 1);*/
	}
}
/* }}} */

PHP_FUNCTION(my_arr_get)  /* {{{ */
{
	HashTable *array;
	zval *key,
		 *zv;

	if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "Hz", &array, &key) == FAILURE) {
		return;
	}

	convert_to_string(key);

	zv = php_my_arr_get(array, key);

	if (zv) {
		RETURN_ZVAL_FAST(zv);
	}

	RETURN_NULL();
}
/* }}} */

PHP_FUNCTION(my_int) /* {{{ */
{
	zval **zv_dest;
	if (zend_hash_index_find(my_ht, 43, (void **) &zv_dest) == SUCCESS) {
		ZVAL_COPY_VALUE(return_value, *zv_dest);
		/*RETURN_ZVAL_FAST(*zv_dest);*/
	}
}
/* }}} */

PHP_MY_API void php_my_index_check(int n) /* {{{ */
{
	if (zend_hash_index_exists(my_ht, n)) {
		php_printf("Index %d is found.\n", n);
	} else {
		php_printf("Index %d not found.\n", n);
	}
}
/* }}} */

PHP_MY_API zval *php_my_arr_get(HashTable *target, zval *name) /* {{{ */ {
	if (target) {
		zval *pzval;
		zval **zv_dest;

		if (zend_memrchr(Z_STRVAL_P(name), '.', Z_STRLEN_P(name))) {
			char *entry, *ptr, *seg;
			entry = estrndup(Z_STRVAL_P(name), Z_STRLEN_P(name));
			if ((seg = php_strtok_r(entry, ".", &ptr))) {
				do {
					if (target == NULL){
						efree(entry);
						return NULL;
					}
					if (zend_symtable_find(target, seg, strlen(seg)+1, (void **)&zv_dest) == SUCCESS) {
						pzval = *zv_dest;
						if (Z_TYPE_PP(zv_dest) == IS_ARRAY) {
							target = Z_ARRVAL_PP(zv_dest);
						} else {
							target = NULL;
						}
					} else {
						efree(entry);
						return NULL;
					}
				} while ((seg = php_strtok_r(NULL, ".", &ptr)));
			}
			efree(entry);
		} else {
			if (zend_symtable_find(target, Z_STRVAL_P(name), Z_STRLEN_P(name), (void **)&zv_dest) == SUCCESS) {
				pzval = *zv_dest;
			} else {
				return NULL;
			}
		}

		return pzval;
	}
	return NULL;
}
/* }}} */

/* {{{ php_my_init_globals
 */
/* Uncomment this function if you have INI entries
static void php_my_init_globals(zend_my_globals *my_globals)
{
	my_globals->global_value = 0;
	my_globals->global_string = NULL;
}
*/
/* }}} */

/* {{{ PHP_MINIT_FUNCTION
 */
PHP_MINIT_FUNCTION(my)
{
	REGISTER_INI_ENTRIES();
	REGISTER_DOUBLE_CONSTANT("MY_VERSION", MY_VERSION, CONST_CS | CONST_PERSISTENT);

	PALLOC_HASHTABLE(my_ht);
	zend_hash_init(my_ht, 0, NULL, NULL, 1);

	zval *zv;
	ALLOC_PERMANENT_ZVAL(zv);
	ZVAL_STRING(zv, "foo", 0);
	zend_hash_index_update(my_ht, 42, &zv, sizeof(zval *), NULL);


	zval *zv1;
	ALLOC_PERMANENT_ZVAL(zv1);
	ZVAL_LONG(zv1, 100);
	zend_hash_index_update(my_ht, 43, &zv1, sizeof(zval *), NULL);
	return SUCCESS;
}
/* }}} */

/* {{{ PHP_MSHUTDOWN_FUNCTION
 */
PHP_MSHUTDOWN_FUNCTION(my)
{
	php_printf("mshutdown.\n");
	zend_hash_destroy(my_ht);
	pefree(my_ht, 1);
	UNREGISTER_INI_ENTRIES();
	return SUCCESS;
}
/* }}} */

/* {{{ PHP_RINIT_FUNCTION
 */
PHP_RINIT_FUNCTION(my)
{
	return SUCCESS;
}
/* }}} */

/* {{{ PHP_RSHUTDOWN_FUNCTION
 */
PHP_RSHUTDOWN_FUNCTION(my)
{
	return SUCCESS;
}
/* }}} */

/* {{{ PHP_MINFO_FUNCTION
 */
PHP_MINFO_FUNCTION(my)
{
	php_info_print_table_start();
	php_info_print_table_header(2, "my support", "enabled");
	php_info_print_table_end();

	DISPLAY_INI_ENTRIES();
}
/* }}} */

/* {{{ my_functions[]
 *
 * Every user visible function must have an entry in my_functions[].
 */
const zend_function_entry my_functions[] = {
	PHP_FE(my_version,	NULL)		/* For testing, remove later. */
	PHP_FE(my_var,	NULL)		/* For testing, remove later. */
	PHP_FE(my_hash,	NULL)		/* For testing, remove later. */
	PHP_FE(my_int,	NULL)		/* For testing, remove later. */
	PHP_FE(my_arr_get,	NULL)		/* For testing, remove later. */
	PHP_FE_END	/* Must be the last line in my_functions[] */
};
/* }}} */

/* {{{ my_module_entry
 */
zend_module_entry my_module_entry = {
	STANDARD_MODULE_HEADER,
	"my",
	my_functions,
	PHP_MINIT(my),
	PHP_MSHUTDOWN(my),
	PHP_RINIT(my),
	PHP_RSHUTDOWN(my),
	PHP_MINFO(my),
	PHP_MY_VERSION,
	STANDARD_MODULE_PROPERTIES
};
/* }}} */

#ifdef COMPILE_DL_MY
ZEND_GET_MODULE(my)
#endif

/*
 * Local variables:
 * tab-width: 4
 * c-basic-offset: 4
 * End:
 * vim600: noet sw=4 ts=4 fdm=marker
 * vim<600: noet sw=4 ts=4
 */
