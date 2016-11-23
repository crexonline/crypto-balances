Promise = require("bluebird")
req = Promise.promisify(require("request"))
_ = require("lodash")
InvalidResponseError = require("../errors").InvalidResponseError

tbtc = (addr) ->
  network = if (addr[0] == '1' || addr[0] == '3') then 'TBTC'

  url = "https://tbtc.blockr.io/api/v1/address/info/#{network}/#{addr}"

  req(url, json: true)
    .timeout(3000)
    .cancellable()
    .spread (resp, json) ->
      if resp.statusCode in [200..299]
        status: "success"
        service: "https://tbtc.blockr.io"
        address: addr
        quantity: json.data.confirmed_balance
        asset: network
      else
        if _.isObject(json) and json.message == "error"
          []
        else
          throw new InvalidResponseError service: url, response: resp

    .catch Promise.TimeoutError, (e) ->
      [status: 'error', service: url, message: e.message, raw: e]
    .catch InvalidResponseError, (e) ->
      [status: "error", service: e.service, message: e.message, raw: e.response]

module.exports = tbtc
