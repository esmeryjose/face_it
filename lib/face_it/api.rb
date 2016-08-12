require 'pry'
require 'json'
require 'net/http'

class FaceIt::API
  attr_accessor :profile_hash

  def initialize(url)
    @url = url
    @profile_hash = {}
    api_request
  end

  def api_request
    uri = URI('https://api.projectoxford.ai/face/v1.0/detect')
    uri.query = URI.encode_www_form({
        # Request parameters
        'returnFaceId' => 'true',
        'returnFaceLandmarks' => 'false',
        'returnFaceAttributes' => 'gender,age,smile,facialHair,glasses'
    })

    request = Net::HTTP::Post.new(uri.request_uri)
    # Request headers
    request['Content-Type'] = 'application/json'
    # Request headers
    request['Ocp-Apim-Subscription-Key'] = 'ff0d4edfcba84b4e89a66dd57e5280f5'
    # Request body
    request.body = "{\"url\":\"#{@url}\"}"

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    http.request(request)
    end
    api_response_converter(JSON.parse(response.body))
  end



  def api_response_converter(response)
    response[0].each do |faceAttributes, attributes|

        if faceAttributes == "faceAttributes"
          attributes.each do |attribute,value|
            if attribute == "facialHair"
              value.each do |facialType, facialHair|
                profile_hash[facialType.to_sym] = facialHair
              end
            elsif attribute == "age"
              profile_hash[attribute.to_sym] = value.to_i
            else
              profile_hash[attribute.to_sym] = value
            end
          end
        end
    end
  end


end
