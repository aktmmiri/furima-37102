function price(){
  const form = document.getElementById("item-price");
  form.addEventListener("keyup", () => {
    const taxPrice = document.getElementById('add-tax-price');
    const profit = document.getElementById('profit');
    taxPrice.innerHTML = `${form.value * 0.1}`;
    profit.innerHTML = `${form.value - form.value * 0.1}`;
  })
};

window.addEventListener("load", price);