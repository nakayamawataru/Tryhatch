require "faraday"
require "json"

# Google My Businessのアカウント取得に2週間かかるため
# 通信をダミーのJSONに切り替えている
# 想定が複雑であったパラ―メータは伏せている
conn = Faraday.new do |conn|
  conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
    stub.get 'https://mybusiness.googleapis.com/v4/accounts/nakayama' do
      [200, {}, JSON.generate({
        "name": "カフェ",
        "accountName": "nakayama",
        # "type": enum (AccountType),
        # "role": enum (AccountRole),
        # "state": {
        #   object (AccountState)
        # },
        "profilePhotoUrl": "https://dummyimage.com/600x400/000/fff",
        "accountNumber": "12345678",
        # "permissionLevel": enum (PermissionLevel),
        # "organizationInfo": {
        #   object (OrganizationInfo)
        # }
      })]
    end
  end
end

account_name = "nakayama"

response = conn.get("https://mybusiness.googleapis.com/v4/accounts/#{account_name}")

json = JSON.parse(response.body)

puts "account_name: #{account_name}"
puts "name: #{json["name"]}"
puts "accountName: #{json["accountName"]}"
puts "profilePhotoUrl: #{json["profilePhotoUrl"]}"
puts "accountNumber: #{json["accountNumber"]}"