const filterPackages = e => {
	const string = e.target.value
    let shownCount = 0;
	Array.from(document.getElementsByClassName('package')).forEach(el => {
		if (!!el.innerText.match(new RegExp(string, 'i'))) {
			el.className = 'package'
            shownCount += 1;
		} else {
			el.className = 'package hidden'
		}
	})
    document.getElementById("package-count").innerHTML = shownCount;
}

document.addEventListener('DOMContentLoaded', (event) => {
	document.getElementById('search-box').addEventListener('keyup', filterPackages)
})
