/-  keygen=keygen-sur
/-  eth=ethereum
|%
++  chaincodes
  |=  network=@t
  ^-  @
  ?:  =('eth-mainnet' network)  1
  ?:  =('eth-sepolia' network)  11.155.111
  !!
::
++  addresses
  |%
  ++  cord
    |=  contract=@tas
    ^-  @t
    ?+  contract  !!
      %'ETH'   '0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9'
      %'USDC'  '0x94a9D9AC8a22534E3FaCa9F4e7F2E2cf85d5E4C8'
    ::
      %router  '0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008'
      %factory  '0x7E0987E5b3a30e3f2828572Bb659A548460a3003'
    ==
  ++  hex
    |=  contract=@tas
    (to-hex (cord contract))
  --
::
++  to-hex
  |=  c=@t
  ^-  @ux
  (rash c ;~(pfix (jest '0x') hex))
::
+$  state-0
  $:  proxy-url=@t
      connected=?
      clients=(set ship)
      height=(unit @)
      base-fee=(unit @)
      priority-fee=(unit @)
      =wallet:keygen
      wallets=(map @tas wallet-info)
      status=[height=@da fee=@da balance=@da history=@da]
  ==
::
+$  versioned-state
  $%  [%0 state-0]
  ==
::
+$  wallet-info
  $:  coin=@tas
      balance=@
      history=(map @ux history-item)
  ==
::
+$  history  (map @ux history-item)
::
+$  history-item
  $:  asset=@t
      block=@ux
      hash=@ux
      from=@ux
      to=@ux
      value=@rd
      time=@t
  ==
::  future for contract call txs: tokens in, tokens out, is mint/burn, contract name, function name, defi app type? (loan swap etc), gas spent
::
::  TODO: separate actions and commands - send eth, send COIN, etc commands vs call-contract, send-tx, populate-tx actions - call-contract here at all, or leave to integrators to construct txdata? for now/testing/demo, include here 
+$  action
  $%  [%ping ~]
      [%get-height ~]
      [%get-fee ~]
      [%get-block-info height=(unit @)]
      [%get-tx-info hash=@t]
      [%get-block-by-tx hash=@t]
      [%get-tx-height hash=@t]
      [%send-eth to=@t value=@]
      [%send-tx tx=@ux]
      :: [%call-contract address=@t data=call-data:rpc:eth eth=@]
      [%send-usdc to=@t value=@]
      [%send-usdc-to-ship to=@p value=@]
      [%swap =swap]
      :: [%quote from=@t to=@t data=@t]
      [%view from=@t to=@t data=@t]
      [%populate-tx from=@t to=@t value=@ data=@t]
      [%pay-ship to=@p value=@]
      [%balance addr=@ux]
      [%history addr=@ux]
  ==
::
+$  command
  $%  [%set-proxy url=@t]
  ==
::  types of battery
::    RPC API call/res
::    our API endpoints for yoke/etc
::    our API endpoints for user/controller
::    Ethereum contract API/ABI ('call')
::
:: +$  call
::   $:  [%transfer token=@t value=@ to=@t]
::       [%swap-eth token=@tas value=@]
::   ==
::
+$  update
  $%  [%connected ~]
      [%disconnected ~]
      [%send-eth success=?]
      [%send-usdc success=?]
      [%send-usdc-to-ship success=?]
      [%swap success=?]
      [%quote out=@]
      [%pay-ship success=?]
      [%height height=@]
      [%block-info =block-info]
      [%block-by-tx =block-info]
      [%tx-info =tx-info]
      [%fee base=@ priority=@]
      [%tx-height hash=@t height=@]
      [%populate-tx gas=@ network=@t nonce=@]
      [%send-tx success=?]
      [%err ~]
      [%balance balances=(map @tas @)]
      [%history coin=@tas =history]
      [%status wen=@da]
  ==
::
+$  response
  $%  [%send-eth success=?]
      [%send-usdc success=?]
      [%send-usdc-to-ship success=?]
      [%swap success=?]
      [%quote out=@]
      [%view data=@t]
      [%pay-ship success=?]
      [%get-height height=@]
      [%get-block-info =block-info]
      [%get-block-by-tx =block-info]
      [%get-tx-info =tx-info]
      [%get-fee =fees]
      [%get-tx-height hash=@t height=@]
      [%populate-tx gas=@ network=@t nonce=@]
      [%send-tx success=?]
      [%err ~]
      [%balance balances=(map @tas @)]
      [%history =history]
  ==
::
+$  block-info
  $:  height=@
      hash=@t
      miner=@t
      gas=@
      txs=(list @t)
  ==
::
+$  tx-info
  $:  hash=@t
      height=@
      to=@t
      from=@t
      value=@
      gas=@
      data=@t
      index=@
  ==
::
+$  fees  [base=@ priority=@]
::
+$  swap  [in=@tas out=@tas value=@]
--
