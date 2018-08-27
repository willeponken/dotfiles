const verticalScroll = 50;
const horizontalScroll = 20;

function up() {
	window.scrollBy(0, -verticalScroll);
}

function down() {
	window.scrollBy(0, verticalScroll);
}

function right() {
	window.scrollBy(horizontalScroll, 0);
}

function left() {
	window.scrollBy(-horizontalScroll, 0);
}

function home() {
	window.scrollBy(0, -document.body.scrollHeight);
}

function bottom() {
	window.scrollBy(0, document.body.scrollHeight);
}

var bindings = {
	'h' : left,
	'l' : right,
	'k' : up,
	'j' : down,
	'g' : home,
	'G' : bottom
}

function isEditable(element) {
	if (element.nodeName.toLowerCase() == "textarea")
		return true;

	// We don't get keypress events for text input, but I don't known
	// if it's a bug, so let's test that.
	if (element.nodeName.toLowerCase() == "input" && element.type == "text")
		return true;

	// Element is editable.
	if (document.designMode == "on" || element.contentEditable == "true") {
		return true;
	}

	return false;
}

function keypress(evt) {
	var target = evt.target;

	// If we're on a editable element, we probably don't want to catch
	// keypress, we just want to write the typed character.
	if (isEditable(target))
		return;

	var key = String.fromCharCode(evt.charCode);
	if (evt.ctrlKey) {
		key = '^' + key;
	}

	var fun = bindings[key];
	if (fun)
		fun();

}

window.addEventListener("keypress", keypress, false);
