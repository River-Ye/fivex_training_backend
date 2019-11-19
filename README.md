# 目錄
[README](#README)
[ERD](#ERD)
[Deploy](Deploy)
[URL](#URL)

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
5. `$ git remote add heroku https://git.heroku.com/todolist-river.git`
6. `$ git push heroku master`
7. `$ heroku run rails db:migrate`
8. 到 [Freenom](https://www.freenom.com/zu/index.html) 買 domain
9. 透過 [Cloudflare](https://www.cloudflare.com/zh-tw/) 設定 HTTPS

寫了一篇設定教學文章「[透過 Freenom 幫 Heroku 網址做 Cloudflare 的設定(Domain 買起來!!)](https://riverye.com/2019/11/19/透過-Freenom-幫-Heroku-網址做-Cloudflare-的設定-Domain-買起來/)」

# URL
URL：[https://todotask.tk](https://todotask.tk)  
Heroku URL：[https://todotask-river.herokuapp.com](https://todotask-river.herokuapp.com)  