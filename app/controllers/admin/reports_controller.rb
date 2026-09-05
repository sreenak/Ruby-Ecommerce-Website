class Admin::ReportsController < AdminController
  def index
    sql1 = "SELECT p.*,count(p.id) as c FROM products as p INNER JOIN line_items as l on l.line_itemable_id=p.id INNER JOIN orders as o on o.id=l.order_id WHERE o.status=2 and l.line_itemable_type='Product' group by p.id order by c desc"
    @best_sales = ActiveRecord::Base.connection.execute(sql1)

    sql2 = "SELECT p.*,count(p.id) as c FROM products as p INNER JOIN line_items as l on l.line_itemable_id=p.id INNER JOIN orders as o on o.id=l.order_id WHERE o.status=2 and l.line_itemable_type='Product' group by p.id order by c asc"
    @worst_sales = ActiveRecord::Base.connection.execute(sql2)

    sql3 = "SELECT l.* FROM products as p JOIN line_items as l on l.line_itemable_id=p.id JOIN orders as o on o.id=l.order_id WHERE o.status=2 and l.created_at > DATE_SUB(CURDATE(), INTERVAL 1 WEEK)"
    @weekly_sales = ActiveRecord::Base.connection.execute(sql3)

    sql4 = "SELECT l.* FROM products as p JOIN line_items as l on l.line_itemable_id=p.id JOIN orders as o on o.id=l.order_id WHERE o.status=2 and l.created_at > DATE_SUB(CURDATE(), INTERVAL 1 MONTH)"
    @monthly_sales = ActiveRecord::Base.connection.execute(sql4)

    sql5 = "SELECT l.* FROM products as p JOIN line_items as l on l.line_itemable_id=p.id JOIN orders as o on o.id=l.order_id WHERE o.status=2 and l.created_at > DATE_SUB(CURDATE(), INTERVAL 6 MONTH)"
    @half_yearly_sales = ActiveRecord::Base.connection.execute(sql5)

    sql6 = "SELECT l.* FROM products as p JOIN line_items as l on l.line_itemable_id=p.id JOIN orders as o on o.id=l.order_id WHERE o.status=2 and l.created_at > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)"
    @yearly_sales = ActiveRecord::Base.connection.execute(sql6)

    sql7 = "SELECT p.*,count(p.id) as c FROM products as p INNER JOIN line_items as l on l.line_itemable_id=p.id INNER JOIN orders as o on o.id=l.order_id WHERE o.status=2 and l.line_itemable_type='Product' group by p.id order by c desc"
    @each_product_sales = ActiveRecord::Base.connection.execute(sql7)


  end
end