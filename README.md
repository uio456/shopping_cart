# Shopping Cart


安裝：

```
$ git clone https://github.com/uio456/shopping_cart.git
$ cd shopping_cart
$ bundle install
```

建立種子資料

```
$ rails db:migrate
$ rails db:seed
$ rails dev:fake_products
```

# User stories

## 提供折扣功能

- 特定商品滿 x 件折 z %
- 特定供應商的場品滿 x 件折 z %
- 訂單滿 x 元折 z %
- 訂單滿 x 元免運費 
- 訂單滿 x 贈送特定商品
- 折扣可限定總共優惠 Y 元
- 可限定日期後不再有任何折扣
## 可成立訂單，無結帳功能

## 後台管理介面

- 變更折扣 % 或條件

- 管理變更商品狀態

- 管理人員權限

  