/-  aether
/-  eth=ethereum
=,  aether
|_  =swap
++  pair
  ^-  @t
  %-  crip  %-  encode-call:rpc:eth
  :-  'getPair(address,address)'
  :~  [%address (hex:addresses in.swap)]
      [%address (hex:addresses out.swap)]
  ==
::
++  reserves
  ^-  @t
  %-  crip  %-  encode-call:rpc:eth
  'getReserves()'^~
::
++  quote
  |=  [res-in=@ res-out=@]
  ^-  @
  (div (mul value.swap res-out) res-in)
::
++  populate
  =,  swap
  |=  [quote=@ to=@ux now=time]
  |^  ^-  @t
  %-  crip  %-  encode-call:rpc:eth
  =-  ~&  -  -
  ^-  call-data:rpc:eth
  ?:  =(%'ETH' in)   swap-from-eth
  ?:  =(%'ETH' out)  swap-for-eth
  swap-tokens
  ::
  ++  swap-from-eth
    :-  'swapExactETHForTokens(uint256,address[],address,uint256)'
    :~  [%uint (div quote 2)]
        [%array ~[address+(hex:addresses %'ETH') address+(hex:addresses out)]]
        [%address to]
        [%uint (add (unt:chrono:userlib now) 180)]
    ==
  ::
  ++  swap-for-eth
    :-  'swapExactTokensForETH(uint256,uint256,address[],address,uint256)'
    swap-from-token
  ::
  ++  swap-tokens
    :-  'swapExactTokensForTokens(uint256,address[],address,uint256)'
    swap-from-token
  ::
  ++  swap-from-token
    :~  [%uint `@ud`value]
        [%uint `@ud`0]
        [%array ~[address+(hex:addresses in) address+(hex:addresses out)]]
        [%address to]
        [%uint (add (unt:chrono:userlib now) 180)]
    ==
  --
--
