function preload(arrayOfImages) {
    $(arrayOfImages).each(function(){
        $('<img/>')[0].src = this;
        // Alternatively you could use:
        // (new Image()).src = this;
    });
}

// Usage:

preload([
    './img/portfolio/portfolio-01.png',
    './img/portfolio/portfolio-02.png',
    './img/portfolio/portfolio-03.png',
    './img/portfolio/portfolio-04.png',
    './img/portfolio/portfolio-05.png',
    './img/portfolio/portfolio-06.png',
    './img/portfolio/portfolio-07.png',
    './img/portfolio/portfolio-08.png',
    './img/portfolio/portfolio-09.png'
]);