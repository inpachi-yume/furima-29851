window.addEventListener("turbolinks:load", function(){
  const adprice = document.getElementById("item-price")
  const fee = document.getElementById('add-tax-price')
  const margin = document.getElementById('profit')
  adprice.addEventListener("input", function(){
    const price = document.getElementById("item-price").value;
    let tax = Math.ceil(price * 0.1);
    let profit = Math.floor(price * 0.9);
    fee.innerHTML = tax
    margin.innerHTML = profit
  })
})