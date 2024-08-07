/@  aether-action
/@  aether-response
/-  ethereum
/-  alchemy-api
/-  aether
/-  aether-neo
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
    ?>  ?=(%send-eth -.action.act)
    =/  =aether-action
      :*  state.act
          %populate-tx  (scot %ux addr.wallet.state.act)
          to.action.act  value.action.act  ''
      ==
    =/  =made:neo  [%alchemy-api [~ aether-action/!>(aether-action)] ~]
    :_  u.pal
    :~  [(snoc here.bowl %populate-tx) %make made]
    ==
  ::
  ++  poke
    |=  [sud=stud:neo vaz=vase]
    ^-  (quip card:neo pail:neo)
    ?>  ?=(%aether-action p.pail)
    =/  state  !<(aether-action q.pail)
    ?>  ?=(%send-eth -.action.state)
    ?+  sud  [~ pail]
        %gift
      =/  gif  !<(gift:neo vaz)
      =/  kid=$@(~ (pair pith:neo aether-response))
        %:  get-gift-diff:aether-neo
          gif  kids.bowl
          [(snoc here.bowl %populate-tx) (snoc here.bowl %send-tx) ~]
        ==
      ?~  kid  [~ pail]
      ?+  -.q.kid  [~ pail]
        ::
          %populate-tx
        =/  tx=typed-transaction:rpc:ethereum
          :*  %0x2
              (chaincodes.aether network.q.kid)
              nonce.q.kid
              (need priority-fee.state.state)
              (need base-fee.state.state)
              (mul gas.q.kid 2)
              `@ux`(slav %ux (crip (cass (trip to.action.state))))
              (add value.action.state gas.q.kid)
              0x0
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
        :~  [(snoc here.bowl %send-tx) %make made]
        ==
        ::
          %send-tx
        [~ aether-response/!>([-.action.state success.q.kid])]
        ::
      ==
    ==
  --
--
