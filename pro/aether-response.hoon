=<  $%  [%send-eth success=?]
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
+$  fees  [base=@ priority=@]
::
--
