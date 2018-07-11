require 'json'

data = JSON.parse(File.open('data.json').read)

output_file = File.open('output.json', 'w')
# output_file.write()


def action(btc_balance, eur_balance, direction, data)
  id = 0
  orders = {}
    if direction == "buy"
       btc_balance = btc_balance + data["queued_orders"][1]["btc_amount"]
       eur_balance = eur_balance - (data["queued_orders"][1]["price"] * data["queued_orders"][1]["btc_amount"])
       orders = {
        "users" => ["id" => data["users"][1]["id"], "btc_balance" => btc_balance, "eur_balance" => eur_balance],
        "queued_orders" => [],
        "orders" => [ "id" => id += 1, "user_id" => data["users"][1]["id"], "direction" => direction, "price" => data["users"][1]["price"], "state" => "executed"]
       }
      elsif direction == "sell"
        btc_balance = btc_balance - data["queued_orders"][1]["btc_amount"]
        eur_balance = eur_balance + (data["queued_orders"][1]["price"] * data["queued_orders"][1]["btc_amount"])
        orders = {
         "users" => ["id" => data["users"][1]["id"], "btc_balance" => btc_balance, "eur_balance" => eur_balance],
         "queued_orders" => [],
         "orders" => [ "id" => id += 1, "user_id" => data["users"][1]["id"], "direction" => direction, "price" => data["users"][1]["price"], "state" => "executed"]
        }
     end
  return orders
end

puts action(data["users"][1]["btc_balance"], data["users"][1]["eur_balance"], data["queued_orders"][1]["direction"], data)

#  N'ayant pas réussi à itérer sur le hash comme demandé, voici ce que j'ai pu faire afin d'y parvenir.

# def action(id, btc_balance, eur_balance, direction, data)
#   id = 0
#   orders = {}
#   data["queued_orders"].each do |x|
#     if direction == "buy"
#        btc_balance = btc_balance + x["btc_amount"]
#        eur_balance = eur_balance - (x["price"] * x["btc_amount"])
#        orders = {
#         "users" => ["id" => data["users"][1]["id"], "btc_balance" => btc_balance, "eur_balance" => eur_balance],
#         "queued_orders" => [],
#         "orders" => [ "id" => id += 1, "user_id" => data["users"][1]["id"], "direction" => direction, "price" => data["users"][1]["price"], "state" => "executed"]
#        }
#       elsif direction == "sell"
#         btc_balance = btc_balance - x["btc_amount"]
#         eur_balance = eur_balance + (x["price"] * x["btc_amount"])
#         orders = {
#          "users" => ["id" => data["users"][1]["id"], "btc_balance" => btc_balance, "eur_balance" => eur_balance],
#          "queued_orders" => [],
#          "orders" => [ "id" => id += 1, "user_id" => data["users"][1]["id"], "direction" => direction, "price" => data["users"][1]["price"], "state" => "executed"]
#         }
#      end
#   end
#   return orders
# end
