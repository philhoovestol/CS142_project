function PhotoSearch(input_did, output_did, search_url) {
	input_obj = document.getElementById(input_did);

	input_obj.oninput = function () {
		input_text = input_obj.value;

		xmlhttp = new XMLHttpRequest();

		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				photos = JSON.parse(xmlhttp.responseText);
				display_photos(output_did, photos);
			}
		}

		search_url += encodeURIComponent(input_text);
		xmlhttp.open("GET", search_url, true);
		xmlhttp.send();
	}

}

function display_photos(div_id, photos) {
	div = document.getElementById(div_id);
	div.innerHTML = "";
	for(i = 0; i < photos.length; i++) {
		photo = photos[i];

		a_obj = document.createElement("a");
		a_obj.href = "/photos/index/" + photo.user_id;

		image_obj = document.createElement("img");
		image_obj.src = "/assets/" + photo.file_name;
		image_obj.class = "photo_index";

		a_obj.appendChild(image_obj);
		div.appendChild(a_obj);
	}
}