/@  aether-response
::
|%
::
++  get-gift-diff
  |=  [gif=gift:neo lor=lore:neo lis=(list pith:neo)]
  ^-  $@(~ (pair pith:neo aether-response))
  ?~  lis  ~
  =/  loo=(unit loot:neo)  (~(get of:neo gif) i.lis)
  ?.  &(?=(^ loo) ?=(%dif mode.u.loo))
    $(lis t.lis)
  =/  ide=(unit idea:neo)  (~(get of:neo lor) i.lis)
  ?.  &(?=(^ ide) ?=(%aether-response p.pail.u.ide))
    $(lis t.lis)
  [i.lis !<(aether-response q.pail.u.ide)]
::
--
