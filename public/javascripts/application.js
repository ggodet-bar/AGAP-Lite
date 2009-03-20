// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

Event.observe(window, 'load', function(){
	var image = $('method_image') ;
	var rect_w = 180 ;
	var rect_h = 100 ;
	var rect_x = image.width / 2 - rect_w / 2;
	var rect_y = image.height / 2 - rect_h / 2;
	$('plus_sign').setStyle({
	position: 'absolute',
	left: image.cumulativeOffset().left + image.width - 26 + 'px',
	top: image.cumulativeOffset().top - 25 + 'px',
	zindex: '10'
	}) ;
	$('plus_sign').observe('click', function(){
		
		$('plus_sign').setStyle({
			visibility: 'hidden'
		}) ;
		
		$('validate_area').setStyle({
			position: 'absolute',
			left: image.cumulativeOffset().left + image.width - 26 + 'px',
			top: image.cumulativeOffset().top - 25 + 'px',
			zindex: '10',
			visibility: 'visible'
		}) ;
		
		$('validate_area').observe('click', function(){
			$('validate_area').setStyle({
				visibility: 'hidden'
			});
			
			$('selection').setStyle({
				visibility: 'hidden'
			});
			
			$('overlay').setStyle({
				visibility: 'hidden'
			}) ;
			
			$('tl_rect').setStyle({
				visibility: 'hidden'
			}) ;
			
			$('bl_rect').setStyle({
				visibility: 'hidden'
			}) ;
			
			$('tr_rect').setStyle({
				visibility: 'hidden'
			}) ;
			
			$('br_rect').setStyle({
				visibility: 'hidden'
			}) ;
			
			$('plus_sign').setStyle({
				visibility: 'visible'
			}) ;
			
			var url = '/process_patterns/choose_pattern/33' ;
			var param = {x: rect_x,	y: rect_y,	w: rect_x, h: rect_h} ;
			alert($('pattern_choice')) ;
			$('pattern_choice').setStyle({
				visibility: 'visible',
				position: 'absolute',
				left: rect_x + 'px',
				top: rect_y + 'px',
				width: '200px',
				height: '200px',
				padding: '10px',
				background: '#dddddd'
		//		opacity: '0'				
			});
			alert(param);
			new Ajax.Updater({success: 'pattern_choice'}, url, {parameters: param, asynchronous:true, method: 'get'}) ;
						
		});
		
		$('overlay').setStyle({
			position: 'absolute',
			top: image.cumulativeOffset().top + 'px',
			left: image.cumulativeOffset().left + 'px',
			width : image.width + 'px',
			height : image.height + 'px',
			background : '#000000',
			zindex: '5',
			opacity:'0.8',
			visibility: 'visible'
		});

		$('selection').setStyle({
			position: 'absolute',
			top: image.cumulativeOffset().top + rect_y + 'px',
			left: image.cumulativeOffset().left + rect_x + 'px',
			width: rect_w + 'px',
			height: rect_h + 'px',
			background: '#dd0000',
			border: 'thin dotted #ffffff',
			opacity: '0.8',
			visibility: 'visible'
		});
		$('tl_rect').setStyle({
			position: 'absolute',
			top: '0px',
			left: '0px',
			visibility: 'visible'
		});
		$('tr_rect').setStyle({
			position: 'absolute',
			top: '0px',
			left: rect_w - 10 + 'px',
			visibility: 'visible'
		});
		$('bl_rect').setStyle({
			position: 'absolute',
			top: rect_h - 10 + 'px',
			left: '0px',
			visibility: 'visible'
		});
		$('br_rect').setStyle({
			position: 'absolute',
			top: rect_h - 10 + 'px',
			left: rect_w - 10 + 'px',
			visibility: 'visible'
		});

	
		new Draggable($('selection')) ;
		var old_sel_x = $('selection').cumulativeOffset().left ;
		var old_sel_y = $('selection').cumulativeOffset().top ;
		var old_sel_w = rect_w ;
		var old_sel_h = rect_h ;

		new Draggable($('tl_rect'), { onDrag : function(){
			rect_x = $('tl_rect').cumulativeOffset().left ;
			rect_y = $('tl_rect').cumulativeOffset().top ;
			rect_w = old_sel_x - rect_x + old_sel_w ;
			rect_h = old_sel_y - rect_y + old_sel_h ;
			$('selection').setStyle({
				top: rect_y + 'px',
				left: rect_x + 'px',
				width: rect_w + 'px',
				height: rect_h + 'px'
			});
			$('tr_rect').setStyle({
				position: 'absolute',
				top: '0px',
				left: rect_w - 10 + 'px',
				visibility: 'visible'
			});
			$('br_rect').setStyle({
				position: 'absolute',
				top: rect_h - 10 + 'px',
				left: rect_w - 10 + 'px',
				visibility: 'visible'
			});
			$('bl_rect').setStyle({
				position: 'absolute',
				top: rect_h - 10 + 'px',
				left: '0px',
				visibility: 'visible'
			});
			old_sel_x = rect_x ;
			old_sel_y = rect_y ;
			old_sel_w = rect_w ;
			old_sel_h = rect_h ;
		}}) ;
		
		
		new Draggable($('br_rect'), { onDrag : function(){
			rect_x = old_sel_x ;
			rect_y = old_sel_y ;
			rect_w = $('br_rect').cumulativeOffset().left - old_sel_x + 10 ;
			rect_h = $('br_rect').cumulativeOffset().top - old_sel_y + 10 ;
			$('selection').setStyle({
				top: rect_y + 'px',
				left: rect_x + 'px',
				width: rect_w + 'px',
				height: rect_h + 'px'
			});
			$('tr_rect').setStyle({
				position: 'absolute',
				top: '0px',
				left: rect_w - 10 + 'px',
				visibility: 'visible'
			});
			$('bl_rect').setStyle({
				position: 'absolute',
				top: rect_h - 10 + 'px',
				left: '0px',
				visibility: 'visible'
			});
			old_sel_x = rect_x ;
			old_sel_y = rect_y ;
			old_sel_w = rect_w ;
			old_sel_h = rect_h ;
		}}) ;
	});
});
