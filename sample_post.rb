require "faraday"
require "json"

# Google My Businessのアカウント取得に2週間かかるため
# 通信をダミーのJSONに切り替えている
# 想定が複雑であったパラ―メータは伏せている
conn = Faraday.new do |conn|
  conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
    stub.get 'https://mybusiness.googleapis.com/v4/accounts/nakayama' do #{name=accounts/nakayama}?
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

acount = 123
location = 456

conn.post("https://mybusiness.googleapis.com/v4/{parent=accounts/#{acount}/locations/#{location}}/localPosts/"

{
"languageCode": "en-US",
"summary": "米よりパン派の皆さんへ",
"event": {
  "title": "ナカヤマ春のパン祭り",
  "schedule": {
      "startDate": {
          "year": 2020,
          "month": 2,
          "day": 5,
        },
        "startTime": {
            "hours": 10,
            "minutes": 0,
            "seconds": 0,
            "nanos": 0,
        },
        "endDate": {
          "year": 2020,
          "month": 2,
          "day": 6,
        },
        "endTime": {
            "hours": 17,
            "minutes": 0,
            "seconds": 0,
            "nanos": 0,
        },
  }
},
"media": [
  {
    "mediaFormat": "PHOTO",
    "sourceUrl": "https://dummyimage.com/600x400/000/fff",
  }
],
})