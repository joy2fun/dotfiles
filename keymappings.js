// an example to create a new mapping `ctrl-y`
mapkey('<Ctrl-y>', 'Show me the money', function() {
    Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
});

// an example to replace `u` with `?`, click `Default mappings` to see how `u` works.
map('?', 'u');

mapkey('pd', 'php xdebug', function(){
    var enabled = localStorage.getItem('PHP_XDEBUG_ENABLED');
    if (enabled > 0) {
        document.cookie='XDEBUG_SESSION='+''+';expires=Mon, 05 Jul 2000 00:00:00 GMT;path=/;';
        localStorage.setItem('PHP_XDEBUG_ENABLED', 0);
        Front.showBanner('PHP xdebug DISABLED !!!', 2000);
    } else {
        document.cookie='XDEBUG_SESSION='+'XDB'+';path=/;';
        localStorage.setItem('PHP_XDEBUG_ENABLED', 1);
        Front.showBanner('PHP xdebug enabled !', 2000);
    }
})

// an example to remove mapkey `Ctrl-i`
unmap('<Ctrl-i>');

// click `Save` button to make above settings to take effect.
// set theme
settings.theme = `
.sk_theme {
    background: #000;
    color: #f90;
}
.sk_theme tbody {
    color: #000;
}
.sk_theme input {
    color: #317ef3;
}
.sk_theme .url {
    color: #38f;
}
.sk_theme .annotation {
    color: #38f;
}

.sk_theme .focused {
    background: #aaa;
}`;
