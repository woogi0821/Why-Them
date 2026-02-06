/**
 * CART LOGIC - Functional Style
 */
window.onload = () => renderCart();

const renderCart = () => {
    const cartItems = JSON.parse(localStorage.getItem("cart") || "[]");
    const container = document.getElementById("cart-list");

    if (cartItems.length === 0) {
        container.innerHTML = "<tr><td colspan='4' class='empty'>장바구니가 비어있습니다.</td></tr>";
        return;
    }

    container.innerHTML = cartItems.map(item => `
        <tr>
            <td class="item-info">
                <img src="${item.img}" alt="">
                <span>${item.name}</span>
            </td>
            <td>₩ ${item.price.toLocaleString()}</td>
            <td>1</td>
            <td>₩ ${item.price.toLocaleString()}</td>
        </tr>
    `).join('');

    const total = cartItems.reduce((acc, curr) => acc + curr.price, 0);
    document.getElementById("final-price").innerText = `₩ ${total.toLocaleString()}`;
};