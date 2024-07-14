/@  aether-state-0
$:  state=aether-state-0
    $=  action
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
        [%swap swap=[in=@tas out=@tas value=@]]
        :: [%quote from=@t to=@t data=@t]
        [%view from=@t to=@t data=@t]
        [%populate-tx from=@t to=@t value=@ data=@t]
        [%pay-ship to=@p value=@]
        [%balance addr=@ux]
        [%history addr=@ux]
    ==
==
