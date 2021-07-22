const filterPackages = e => {
	const string = e.target.value
	Array.from(document.getElementsByClassName('package')).forEach(el => {
		if (!!el.innerText.match(string)) {
			el.className = 'package'
		} else {
			el.className = 'package hidden'
		}
	})
}

document.addEventListener('DOMContentLoaded', (event) => {
	document.getElementById('search-box').addEventListener('keyup', filterPackages)
})
