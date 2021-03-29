function calc () {
  const priceNum = document.getElementById('item-price');
  priceNum.addEventListener("keyup", () => {
    const tax = document.getElementById('add-tax-price');
    const profit = document.getElementById('profit');
    const inputVal = priceNum.value;
    const calcTax = Math.round(inputVal * 0.1);
    tax.innerHTML = calcTax;
    profit.innerHTML = inputVal - calcTax;
  });
}

window.addEventListener('load', calc);