$(document).ready(function(){
    $('#tag-input').autocomplete({
        source: '/tags/autocomplete',
        minLength: 3,
    });
});