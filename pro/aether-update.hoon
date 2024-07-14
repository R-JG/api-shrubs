=<  $%  [%connected ~]
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
|%
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
::
--
