var html = "";
var temp = 5;
const date = new Date();
const listYear = document.querySelector(".list-year");
document.querySelector(".clear").addEventListener("click", (e) => {
    temp += 5;
    renderListYear(temp);
})
var renderListYear = (tempYear) => {
    html = "";
    for (let i = 0; i < temp; i++) {
        console.log(date.getUTCFullYear())
        var jump = date.getUTCFullYear() - i;
        console.log(jump)
        html += `<span
            class="year-item"><input class="hide" name="radio1" type="radio" id=y${jump}><label
            class="free-label" for="y${jump}">${jump}</label></span>`
    }
    console.log(html)
    listYear.innerHTML = html;
}
renderListYear(temp);