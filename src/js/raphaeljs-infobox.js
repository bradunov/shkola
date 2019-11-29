// Copyright 2012: Kelley Reynolds, RubyScale
// http://rubyscale.com/blog/2010/11/22/embedding-arbitrary-html-into-raphaeljs/

// TBD: Bozidar: maybe remove JQuery as we only use it here

// Takes a raphaeljs object, some options, and some container attributes
  function Infobox(r, options, attrs) {
    options = options || {};
    attrs = attrs || {};
    this.paper = r;
    this.x = options.x || 0;
    this.y = options.y || 0;
    this.width = options.width || this.paper.width;
    this.height = options.height || this.paper.height;
    this.rounding = options.rounding || 0;
    this.show_border = options.with_border || false;
    this.container = this.paper.rect(this.x, this.y, this.width, this.height, this.rounding).attr(attrs);
    var container_id = this.container.node.parentNode.parentNode.id;
    container_id = container_id || this.container.node.parentNode.parentNode.parentNode.id;
    this.raph_container = jQuery('#' + container_id);
    
    if (!this.show_border) { this.container.hide(); }
    
    this.div = jQuery('<div style="position: absolute; overflow: auto; width: 0; height: 0;"></div>').insertAfter(this.raph_container);
    jQuery(document).bind('ready', this, function(event) { event.data.update(); });
    jQuery(window).bind('resize', this, function(event) { event.data.update(); });

    this.update();
  }

  Infobox.prototype.update = function() {
    var o = this.paper.canvas.getBoundingClientRect();
    this.div.css({
      'top': (this.y + (this.rounding) + (o.y)) + 'px',
      'left': (this.x + (this.rounding) + (o.x)) + 'px'
      'height': (this.height - (this.rounding*2) + 'px'),
      'width': (this.width - (this.rounding*2) + 'px')
    });
  }

