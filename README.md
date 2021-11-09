## usersテーブル

| Column                | Type   | Options      |
|:---------------------:|:------:|:------------:|
| nickname              | string | null: false  |
| email                 | string | null: false  |
| encrypted_password    | string | null: false  |
| last_name             | string | null: false  |
| first_name            | string | null: false  |
| last_name_kana        | string | null: false  |
| first_name_kana       | string | null: false  |
| birth_date            | date   | null: false  |

## アソシエーション

- has_many :items
- has_many :orders

## itemsテーブル

| Column              | Type       | Options                        |
|:-------------------:|:----------:|:------------------------------:|
| name                | string     | null: false                    |
| info                | text       | null: false                    |
| category            | string     | null: false                    |
| sales_status        | string     | null: false                    |
| shipping_fee_status | string     | null: false                    |
| prefecture          | string     | null: false                    |
| scheduled_delivery  | string     | null: false                    |
| price               | integer    | null: false                    |
| tax_price           | integer    | null: false                    |
| profit              | integer    | null: false                    |
| user_id             | references | null: false, foreign_key: true |

## アソシエーション

- belongs_to :user
- has_one :order

## ordersテーブル

| Column              | Type       | Options                        |
|:-------------------:|:----------:|:------------------------------:|
| user_id             | references | null: false, foreign_key: true |
| item_id             | references | null: false, foreign_key: true |

## アソシエーション

- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addressesテーブル

| Column            | Type       | Options                        |
|:-----------------:|:----------:|:------------------------------:|
| postal_code       | integer    | null: false                    |
| prefecture        | string     | null: false                    |
| city              | string     | null: false                    |
| addresses         | string     | null: false                    |
| building          | string     |                                |
| phone_number      | integer    | null: false                    |
| order_id          | references | null: false, foreign_key: true |

## アソシエーション

- belongs_to :order