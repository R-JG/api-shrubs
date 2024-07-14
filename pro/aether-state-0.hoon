=<  $:  proxy-url=@t
        connected=?
        clients=(set ship)
        height=(unit @)
        base-fee=(unit @)
        priority-fee=(unit @)
        =wallet
        wallets=(map @tas wallet-info)
        status=[height=@da fee=@da balance=@da history=@da]
    ==
::
|%
::
+$  wallet-info
  $:  coin=@tas
      balance=@
      history=(map @ux history-item)
  ==
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
::
+$  wallet  [keys=[public=@ux private=@ux] addr=@ux chain=@ux]
::
--
