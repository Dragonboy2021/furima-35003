# テーブル設計

## users テーブル

| Column               | Type   | Options     |
| -------------------- | ------ | ----------- |
| nickname             | string | null: false |
| email                | string | null: false |
| password             | string | null: false |
| first_name           | string | null: false |
| last_name            | string | null: false |
| phonetic_first_name  | string | null: false |
| phonetic_last_name   | string | null: false |
| birthday             | string | null: false |

### Association

- has_many: products
- has_many: orders

## products テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| title         | string     | null: false                    |
| category      | string     | null: false                    |
| info          | string     | null: false                    |
| quality       | string     | null: false                    |
| location      | string     | null: false                    | 
| price         | number     | null: false                    |
| delivery_date | string     | null: false                    |
| delivery_fee  | boolean    | null: false                    |
| user          | references | null: false, foreign_key: true |
| order         | references | foreign_key: true              |

## Association

- belongs_to: user
- has_one: order
- has_one: image

## orders テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user             | references | null: false, foreign_key: true |
| product          | references | null: false, foreign_key: true |
| shipping_address | references | null: false, foreign_key: true |

## Association

- belongs_to: user
- has_one: product
- has_one: shipping_address

## shipping_addresses テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| postal_address | string     | null: false                    |
| state          | string     | null: false                    |
| city           | string     | null: false                    |
| street         | string     | null: false                    |
| building       | string     |                                |
| phone          | string     | null: false                    |
| order          | references | null: false, foreign_key: true |

## Association

- has_one: order