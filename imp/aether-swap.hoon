/@  aether-action
/@  aether-response
/-  ethereum
/-  alchemy-api
/-  aether
/-  aether-neo
/-  swaps
^-  kook:neo
|%
++  state  [%or pro/%aether-action pro/%aether-response ~]
++  poke   (sy %gift ~)
++  kids
  :+  ~  %y
  %-  my
  :~  :+  [|/%tas |]
        [%or pro/%aether-action pro/%aether-response ~]
      (sy %iris-res ~)
      ::
      :+  [&/%swapdata |]
        pro/%sig
      ~
      ::
      :+  [&/%nonce |]
        pro/%sig
      ~
  ==
++  deps   *deps:neo
++  form
  ^-  form:neo
  |_  [=bowl:neo =aeon:neo =pail:neo]
  ++  init
    |=  pal=(unit pail:neo)
    ^-  (quip card:neo pail:neo)
    ?>  &(?=(^ pal) ?=(%aether-action p.u.pal))
    =/  act  !<(aether-action q.u.pal)
    ?>  ?=(%swap -.action.act)
    =/  us=@t  (scot %ux addr.wallet.state.act)
    =/  router=@t  (cord:addresses:aether %router)
    =/  factory=@t  (cord:addresses:aether %factory)
    =/  =aether-action
      :*  state.act
          %view  us  factory  ~(pair swaps swap.action.act)
      ==
    =/  =made:neo  [%alchemy-api [~ aether-action/!>(aether-action)] ~]
    :_  u.pal
    :~  [(snoc here.bowl %view-1) %make made]
    ==
  ::
  ++  poke
    |=  [sud=stud:neo vaz=vase]
    ^-  (quip card:neo pail:neo)
    ?>  ?=(%aether-action p.pail)
    =/  state  !<(aether-action q.pail)
    ?>  ?=(%swap -.action.state)
    |^
    ?+  sud  [~ pail]
        %gift
      =/  gif  !<(gift:neo vaz)
      =/  kid=$@(~ (pair pith:neo aether-response))
        %:  get-gift-diff:aether-neo
          gif  kids.bowl
          :~  (snoc here.bowl %view-1)
              (snoc here.bowl %view-2)
              (snoc here.bowl %populate-tx-1)
              (snoc here.bowl %send-tx-1)
              (snoc here.bowl %populate-tx-2)
              (snoc here.bowl %send-tx-2)
          ==
        ==
      ?~  kid  [~ pail]
      ?+  ^-(iota:neo (rear p.kid))  [~ pail]
        ::
          %view-1
        ?>  ?=(%view -.q.kid)
        =/  pair-addr=@t
          (scot %ux (decode-results:abi:ethereum data.q.kid ~[%address]))
        =/  =aether-action
          :*  state.state
              %view  us  pair-addr  ~(reserves swaps swap.action.state)
          ==
        =/  =made:neo  [%alchemy-api [~ aether-action/!>(aether-action)] ~]
        :_  pail
        :~  [(snoc here.bowl %view-2) %make made]
        ==
        ::
          %view-2
        ?>  ?=(%view -.q.kid)
        =/  [res-a=@ res-b=@ @]
          (decode-results:abi:ethereum data.q.kid ~[%uint %uint %uint])
        =/  [res-in=@ res-out=@]
          ?:  %+  lth
                (hex:addresses:aether in.swap.action.state)
              (hex:addresses:aether out.swap.action.state)
          [res-a res-b]  [res-b res-a]
        =/  qot=@
          (~(quote swaps swap.action.state) res-in res-out)
        =/  dat=@t
          (~(populate swaps swap.action.state) qot addr.wallet.state.state now.bowl)
        =/  =aether-action
          :*  state.state
              %populate-tx  us  (cord:addresses:aether in.swap.action.state)
              0  allowdat
          ==
        =/  =made:neo  [%alchemy-api [~ aether-action/!>(aether-action)] ~]
        :_  pail
        :~  [(snoc here.bowl %swapdata) %make [%sig [~ sig/!>(dat)] ~]]
            [(snoc here.bowl %populate-tx-1) %make made]
        ==
        ::
          %populate-tx-1
        ?>  ?=(%populate-tx -.q.kid)
        =/  approve-tx=typed-transaction:rpc:ethereum
          :*  %0x2
              (chaincodes.aether network.q.kid)
              nonce.q.kid
              (need priority-fee.state.state)
              (need base-fee.state.state)
              (mul gas.q.kid 2)
              (hex:addresses:aether in.swap.action.state)
              0
              (rash allowdat ;~(pfix (jest '0x') hex))
              ~
          ==
        =/  signed-approve=@ux
          (sign-typed-transaction:key:ethereum approve-tx private.keys.wallet.state.state)
        =/  =aether-action
          :*  state.state
              %send-tx  signed-approve
          ==
        =/  =made:neo  [%alchemy-api [~ aether-action/!>(aether-action)] ~]
        :_  pail
        :~  [(snoc here.bowl %nonce) %make [%sig [~ sig/!>(nonce.q.kid)] ~]]
            [(snoc here.bowl %send-tx-1) %make made]
        ==
        ::
          %send-tx-1
        ?>  ?=(%send-tx -.q.kid)
        =/  dat=@t  !<(@t q.pail:(~(got of:neo kids.bowl) (snoc here.bowl %swapdata)))
        =/  =aether-action
          :*  state.state
              %populate-tx  us  router  tx-value  dat
          ==
        =/  =made:neo  [%alchemy-api [~ aether-action/!>(aether-action)] ~]
        :_  pail
        :~  [(snoc here.bowl %populate-tx-2) %make made]
        ==
        ::
          %populate-tx-2
        ?>  ?=(%populate-tx -.q.kid)
        =/  dat=@t  !<(@t q.pail:(~(got of:neo kids.bowl) (snoc here.bowl %swapdata)))
        =/  non=@   !<(@ q.pail:(~(got of:neo kids.bowl) (snoc here.bowl %nonce)))
        =?  nonce.q.kid  =(nonce.q.kid non)  +(nonce.q.kid)
        =/  tx=typed-transaction:rpc:ethereum
          :*  %0x2
              (chaincodes.aether network.q.kid)
              nonce.q.kid
              (need priority-fee.state.state)
              (need base-fee.state.state)
              (mul gas.q.kid 2)
              (rash router ;~(pfix (jest '0x') hex))
              tx-value
              (rash dat ;~(pfix (jest '0x') hex))
              ~
          ==
        =/  signed=@ux
          (sign-typed-transaction:key:ethereum tx private.keys.wallet.state.state)
        =/  =aether-action
          :*  state.state
              %send-tx  signed
          ==
        =/  =made:neo  [%alchemy-api [~ aether-action/!>(aether-action)] ~]
        :_  pail
        :~  [(snoc here.bowl %send-tx-2) %make made]
        ==
        ::
          %send-tx-2
        ?>  ?=(%send-tx -.q.kid)
        [~ aether-response/!>([-.action.state success.q.kid])]
        ::
      ==
    ==
    ::
    ++  us
      ^-  @t
      (scot %ux addr.wallet.state.state)
    ::
    ++  router
      ^-  @t
      (cord:addresses:aether %router)
    ::
    ++  tx-value
      ^-  @
      ?:  =(%'ETH' in.swap.action.state)
        value.swap.action.state
      0
    ::
    ++  allowdat
      ^-  @t
      %-  crip
      %-  encode-call:rpc:ethereum
      :-  'approve(address,uint256)'
      :~  [%address (hex:addresses:aether %router)]
          [%uint (mul 100 value.swap.action.state)]
      ==
    ::
    --
  --
--
