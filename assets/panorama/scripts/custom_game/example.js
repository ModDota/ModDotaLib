(function () {
    Game.AddCommand("storage_testpanorama", function(cmdname, key, value) {
        if (value !== undefined) {
            var seqNum = GameEvents.SetKey("testing2", key, value, function(sequenceNumber, success) {
                $.Msg("[Testing] " + sequenceNumber + " | " + success);
            });
            $.Msg("[Testing] " + seqNum);
        } else {
            var seqNum = GameEvents.GetKey("testing2", key, function(sequenceNumber, success, value) {
                if (success == 0) {
                    $.Msg("[Testing] " + sequenceNumber + " | " + success + " | " + value);
                } else {
                    $.Msg("[Testing] " + sequenceNumber + " | " + success);
                }
            });
            $.Msg("[Testing] " + seqNum);
        }
    }, "Fuck", 0);
})();