# テーブル設計

## users テーブル

| Column              | Type   | Options                   |
| ------------------- | ------ | ------------------------- |
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| first_name          | string | null: false               |
| last_name           | string | null: false               |
| phonetic_first_name | string | null: false               |
| phonetic_last_name  | string | null: false               |
| birthday            | date   | null: false               |

### Association

- has_many: products
- has_many: orders

## products テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| title            | string     | null: false                    |
| category_id      | integer    | null: false                    |
| info             | text       | null: false                    |
| quality_id       | integer    | null: false                    |
| location_id      | integer    | null: false                    | 
| price            | integer    | null: false                    |
| delivery_date_id | integer    | null: false                    |
| delivery_fee_id  | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

## Association

- belongs_to: user
- has_one: order

## orders テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user             | references | null: false, foreign_key: true |
| product          | references | null: false, foreign_key: true |

## Association

- belongs_to: user
- belongs_to: product
- has_one: shipping_address

## shipping_addresses テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| postal_address | string     | null: false                    |
| state_id       | integer    | null: false                    |
| city           | string     | null: false                    |
| street         | string     | null: false                    |
| building       | string     |                                |
| phone          | string     | null: false                    |
| order          | references | null: false, foreign_key: true |

## Association

- belongs_to: order