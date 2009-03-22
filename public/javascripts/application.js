// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function observeThisPage(current_pattern_id, image_path, width, height) {
Event.observe(window, 'load', function(){
	var image = $('method_image') ;
	
	image.setStyle({
		display: 'block',
		height: height + 'px',
		width: width + 'px',
		background: "url(" + image_path + ") no-repeat",
		position: 'relative',
		border: 'solid thin #000000'
	}) ;
	

	var rect_w = 180 ;
	var rect_h = 100 ;
	var rect_x = width / 2 - rect_w / 2;
	var rect_y = height / 2 - rect_h / 2;
	$('plus_sign').setStyle({
	position: 'absolute',
	left: image.cumulativeOffset().left + width - 26 + 'px',
	top: image.cumulativeOffset().top - 25 + 'px',
	zindex: '10'
	}) ;
	$('plus_sign').observe('click', function(){
		rect_w = 180 ;
		rect_h = 100 ;
		rect_x = width / 2 - rect_w / 2;
		rect_y = height / 2 - rect_h / 2;
		
		
		$('plus_sign').setStyle({
			visibility: 'hidden'
		}) ;
		
		$('validate_area').setStyle({
			position: 'absolute',
			left: image.cumulativeOffset().left + width - 26 + 'px',
			top: image.cumulativeOffset().top - 25 + 'px',
			zindex: '10',
			visibility: 'visible'
		}) ;
		
		
		
		$('overlay').setStyle({
			position: 'relative',
			top: '0px',
			left: '0px',
			width : width + 'px',
			height : height + 'px',
			background : '#000000',
			zindex: '5',
			opacity:'0.8',
			visibility: 'visible'
		});

		$('selection').setStyle({
			position: 'absolute',
			top: rect_y + 'px',
			left: rect_x + 'px',
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
	
		/* TODO  Passer les données ci-dessous en fonction ? */
		var select_draggable = new Draggable($('selection') , {onDrag : function(){
			old_sel_x = rect_x ;
			old_sel_y = rect_y ;
			old_sel_w = rect_w ;
			old_sel_h = rect_h ;
			rect_x = $('selection').positionedOffset().left ;
			rect_y = $('selection').positionedOffset().top ;
		}}) ;


		var tl_rect_draggable = new Draggable($('tl_rect'), { onDrag : function(){
			old_sel_x = rect_x ;
			old_sel_y = rect_y ;
			old_sel_w = rect_w ;
			old_sel_h = rect_h ;
			
			rect_x = $('tl_rect').positionedOffset().left + $('selection').positionedOffset().left ;
			rect_y = $('tl_rect').positionedOffset().top + $('selection').positionedOffset().top;		
			rect_w = calcWidth(rect_x, old_sel_x, old_sel_w) ;
			rect_h = calcHeight(rect_y, old_sel_y, old_sel_h) ;
			
			// alert('x : ' + rect_x + ' old_x : ' + old_sel_x + ' new w : ' + rect_w + ', old w : ' + old_sel_w) ;
			// old_sel_x - rect_x + old_sel_w ;
			// rect_h = old_sel_y - rect_y + old_sel_h ;

			$('tr_rect').setStyle({
				top: '0px',
				left: rect_w - 10 + 'px'
			});
			$('br_rect').setStyle({
				top: rect_h - 10 + 'px',
				left: rect_w - 10 + 'px'
			});
			$('bl_rect').setStyle({
				top: rect_h - 10 + 'px',
				left: '0px'
			});
			
			$('selection').setStyle({
				top: rect_y + 'px',
				left: rect_x + 'px',
				width: rect_w + 'px',
				height: rect_h + 'px'
			});
		}}) ;
		
		
		var br_rect_draggable = new Draggable($('br_rect'), { onDrag : function(){
			old_sel_x = rect_x ;
			old_sel_y = rect_y ;
			old_sel_w = rect_w ;
			old_sel_h = rect_h ;
			
			rect_x = old_sel_x ;
			rect_y = old_sel_y ;
			rect_w = $('br_rect').positionedOffset().left + $('selection').positionedOffset().left - old_sel_x + 10 ;
			rect_h = $('br_rect').positionedOffset().top + $('selection').positionedOffset().top - old_sel_y + 10 ;
			
			$('tr_rect').setStyle({
				top: '0px',
				left: rect_w - 10 + 'px'
			});
			$('bl_rect').setStyle({
				top: rect_h - 10 + 'px',
				left: '0px'
			});

			$('selection').setStyle({
				top: rect_y + 'px',
				left: rect_x + 'px',
				width: rect_w + 'px',
				height: rect_h + 'px'
			});
		}}) ;
		
		$('validate_area').observe('click', function(){
			select_draggable.destroy() ;
			tl_rect_draggable.destroy() ;
			br_rect_draggable.destroy() ;
			
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
			
			var url = '/process_patterns/choose_pattern/' + current_pattern_id ;
			var param = {x: rect_x,	y: rect_y,	w: rect_w, h: rect_h} ;
			// alert('Should display pattern choice' + rect_w) ;
			$('pattern_choice').setStyle({
				visibility: 'visible',
				position: 'absolute',
				left: rect_x + 'px',
				top: rect_y + 'px'
		//		opacity: '0'				
			});
			// alert('Should now launch the updater! ' + param.x);
			new Ajax.Updater({success: 'pattern_choice'}, url, {parameters: param, asynchronous:true, method: 'get'}) ;
						
		});
	});
 });
}

function calcWidth(new_x, old_x, old_w) {
	tmp_x = old_x - new_x ;
	// if (tmp_x < 0) {
	// 	tmp_x = - tmp_x ;
	// }
	
	return tmp_x + old_w ;
}

function calcHeight(new_y, old_y, old_h) {
	return calcWidth(new_y, old_y, old_h) ;
}

function registerArea(current_pattern_id, pattern_id, x, y, w, h) {
	
	
	var new_dd = new Element('dd', {id: "dd_" + pattern_id}) ;
	var new_link = new Element('a', {id: "link_" + pattern_id}) ;
	new_dd.appendChild(new_link) ;
	new_dd.setStyle({
		left: x + 'px',
		top: y + 'px'
	}) ;
	new_link.setStyle({
		display: 'block',
		width: w + 'px',
		height: h + 'px'
	}) ;
	$('method_image').appendChild(new_dd) ;
	
	$('pattern_choice').setStyle({
		visibility: 'hidden'
	});
	
	var param = {pattern_id: pattern_id, x: x, y: y, w: w, h: h} ;
	var url = '/process_patterns/save_map/' + current_pattern_id ;
	// alert(param);
	new Ajax.Request(url, {parameters: param, method: 'get', onSucess: alert("Map has been added!")}) ;
}