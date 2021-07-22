const filterPackages = query => {
	const string = query;
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
    document.getElementById('search-box').addEventListener('keyup', (e) => filterPackages(e.target.value))
    if (window.URLSearchParams) {
        let params = new URLSearchParams(window.location.search);
        if (params.has('q')) {
            document.getElementById('search-box').value = params.get('q');
            filterPackages(params.get('q'));
        }
    }
})

