bs58check = require('bs58check')

module.exports =
  chainso: (addr) ->
    chainso = RegExp('^[13][a-km-zA-HJ-NP-Z1-9]{25,34}$').test(addr) ||
      RegExp('^[LD][a-km-zA-HJ-NP-Z1-9]{33}$').test(addr)
    if chainso
      return true
    else false

  ethereum: (addr) ->
    RegExp('^(0x)?[0-9a-f]{40}$').test(addr)

  ripple: (addr) ->
    RegExp('^r[1-9A-HJ-NP-Za-km-z]{25,33}$').test(addr)

  cryptoid: (addr) ->
    RegExp('^[CGRXPB][a-km-zA-HJ-NP-Z1-9]{33}$').test(addr)

  openassets: (addr) ->
    try decoded = bs58check.decode(addr)
    catch error
      return false
    decoded[0] == 19

  counterparty: (addr) ->
    RegExp('^[13][a-km-zA-HJ-NP-Z1-9]{25,34}$').test(addr)

  nxt: (addr) ->
    RegExp('^(NXT|nxt)(-[a-zA-Z0-9]{4,5}){4}$').test(addr)

  nxtassets: (addr) ->
    RegExp('^(NXT|nxt)(-[a-zA-Z0-9]{4,5}){4}$').test(addr)

  nem: (addr) ->
    RegExp('^[nN][a-zA-Z0-9]{5}(-[a-zA-Z0-9]{4,6}){6}$').test(addr)