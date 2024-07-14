/@  aether-action
/@  aether-response
/-  alchemy-api
^-  kook:neo
|%
++  state  [%or pro/%aether-action pro/%aether-response ~]
++  poke   (sy %iris-res ~)
++  kids   *kids:neo
++  deps   *deps:neo
++  form
  ^-  form:neo
  |_  [=bowl:neo =aeon:neo =pail:neo]
  ++  init
    |=  pal=(unit pail:neo)
    ^-  (quip card:neo pail:neo)
    ?>  &(?=(^ pal) ?=(%aether-action p.u.pal))
    =/  act  !<(aether-action q.u.pal)
    =/  req=request:http
      (~(action-to-request alchemy-api state.act) action.act)
    ~&  >>  alchemy-request/req
    :_  u.pal
    :~  [#/[p/our.bowl]/$/iris %poke iris-req/!>([/aether-api req])]
    ==
  ::
  ++  poke
    |=  [sud=stud:neo vaz=vase]
    ^-  (quip card:neo pail:neo)
    ?+  sud  [~ pail]
        %iris-res
      ?>  ?=(%aether-action p.pail)
      =/  state  !<(aether-action q.pail)
      =+  !<([hand=pith dat=client-response:iris] vaz)
      =/  res=aether-response
        (~(handle-response alchemy-api state.state) action.state dat)
      ~&  >  alchemy-response/res
      [~ aether-response/!>(res)]
    ==
  --
--
