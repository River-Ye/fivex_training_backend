# 目錄
[README](#README)
[ERD](#ERD)

# README
* Ruby version 2.6.3

* Rails version 5.2.3

* System dependencies

* Configuration

* Database creation postgresql

* Database initialization postgresql

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

---

# ERD
## 實際 ERD
### Task model
| Key  | Field   | Type   |
| ---- | ------- | ------ |
|      | title   | string |
|      | content | text   |

## 預設最終 ERD
![](https://i.imgur.com/YsLjHue.png)

URL：[lucidchart (ERD)](https://www.lucidchart.com/documents/view/78befe44-6432-4bb0-8769-a333bed76869)

# Deploy
1. 註冊 [Heroku](https://dashboard.heroku.com/) 帳號
2. `$ heroku create`
3. 更改 Heroku 網站上的 remote name
4. `$ git remote rm old_name`
5. `$ git remote add heroku https://git.heroku.com/todolist-river.git
`
6. `$ git push heroku master`
7. `$ heroku run rails db:migrate`