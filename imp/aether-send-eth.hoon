/@  aether-action
/@  aether-response
/-  alchemy-api
/-  aether
/-  ethereum
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
    =/  state
      ?>  ?=(%aether-action p.pail)
      !<(aether-action q.pail)
    ?>  ?=(%send-eth -.action.state)
    ?+  sud  [~ pail]
        %gift
      =/  kid=(unit aether-response)
        =/  pop=(unit idea:neo)
          (~(get of:neo kids.bowl) (snoc here.bowl %populate-tx))
        ?:  &(?=(^ pop) ?=(%aether-response p.pail.u.pop))
          [~ !<(aether-response q.pail.u.pop)]
        =/  sen=(unit idea:neo)
          (~(get of:neo kids.bowl) (snoc here.bowl %send-tx))
        ?:  &(?=(^ sen) ?=(%aether-response p.pail.u.sen))
          [~ !<(aether-response q.pail.u.sen)]
        ~
      ?~  kid  [~ pail]
      ?+  -.u.kid  [~ pail]
        ::
          %populate-tx
        =/  tx=typed-transaction:rpc:ethereum
          :*  %0x2
              (chaincodes.aether network.u.kid)
              nonce.u.kid
              (need priority-fee.state.state)
              (need base-fee.state.state)
              (mul gas.u.kid 2)
              `@ux`(slav %ux (crip (cass (trip to.action.state))))
              (add value.action.state gas.u.kid)
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
        [~ aether-response/!>(u.kid)]
        ::
      ==
    ==
  --
--
