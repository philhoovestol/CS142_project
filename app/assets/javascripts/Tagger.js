
function Tagger(phot_did, tagr_did, x1_id, y1_id, wid_id, hei_id) {
	var photo_div = document.getElementById(phot_did);
	var tagr_div = document.getElementById(tagr_did);

	photo_div.onmousedown = function (e) {
		var x1 = e.pageX - photo_div.offsetLeft;
		var y1 = e.pageY - photo_div.offsetTop;
		//form.setAttribute("value", "x1: " + e.pageX)
		//form.setAttribute("value", "y1: " + e.pageY)

		document.onmouseup = function() {
			photo_div.onmouseup();
		}

		photo_div.onmousemove = function(e) {
			var x2 = e.pageX - photo_div.offsetLeft;
			var y2 = e.pageY - photo_div.offsetTop;

			if(x2 > photo_div.offsetWidth - 4) {
				x2 = photo_div.offsetWidth - 4;
			}
			if(x2 < 0) {
				x2 = 0;
			}
			if(y2 < 0) {
				y2 = 0;
			}
			if(y2 > photo_div.offsetHeight - 4) {
				y2 = photo_div.offsetHeight - 4;
			}

			setDivRect(tagr_did, x1, x2, y1, y2, x1_id, y1_id, wid_id, hei_id);
			//form.setAttribute("value", "x2: " + e.pageX)
			//form.setAttribute("value", "y2: " + e.pageY)
		}
		photo_div.onmouseup = function() {
			photo_div.onmousemove = null;
		}
	}
	//photo_div.ondragstart = function() { return false }

}

function setDivRect(div_id, x1, x2, y1, y2, x1_id, y1_id, wid_id, hei_id) {

	div = document.getElementById(div_id);

	console.log(x1_id);
	x1_obj = document.getElementById(x1_id);
	y1_obj = document.getElementById(y1_id);
	wid_obj = document.getElementById(wid_id);
	hei_obj = document.getElementById(hei_id);

	if(x1 > x2) {
		var x_helper = x2;
		x2 = x1;
		x1 = x_helper;
	}

	if(y1 > y2) {
		var y_helper = y2;
		y2 = y1;
		y1 = y_helper;
	}

	div.style.left = x1 + "px";
	div.style.top = y1 + "px";
	div.style.width = (x2 - x1) + "px";
	div.style.height = (y2 - y1) + "px";

	x1_obj.value = x1;
	y1_obj.value = y1;
	wid_obj.value = x2 - x1;
	hei_obj.value = y2 - y1;
}
