require "faraday"
require "json"
require 'webmock'

puts "シミュレーションモードで動作中"

include WebMock::API
WebMock.enable!

stub_request(:post, "https://mybusiness.googleapis.com/v4/accounts/123/locations/456/localPosts").to_return(
  body: JSON.generate({
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
  }),
  status: 200
)

acount = 123
location = 456

puts "account: #{acount} location:#{location}"
puts "投稿開始"

response = Faraday.post("https://mybusiness.googleapis.com/v4/accounts/#{acount}/locations/#{location}/localPosts", {
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

puts response.body

if response.status == 200
  puts "投稿成功"
else
  puts "投稿失敗"
end