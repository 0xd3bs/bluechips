mod xgb_inference;

fn predict(input_vector: Span<i32>) -> i32 {
    let tree_0 = xgb_inference::Tree {
        base_weights: array![4065725, 6208191, -115574993, 338979, 11268655, -16507199, -6276180]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 0, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            278711724, 200281154, -27476514, 338979, 11268655, -16507199, -6276180,
        ]
            .span(),
    };
    let tree_1 = xgb_inference::Tree {
        base_weights: array![1132679, 3590795, -93126414, 97972, 10088603, -10408327, -3286601]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 0, 0, 0, 0, 0, 0].span(),
        split_conditions: array![
            278711724, 201900992, 409486047, 97972, 10088603, -10408327, -3286601,
        ]
            .span(),
    };
    let tree_2 = xgb_inference::Tree {
        base_weights: array![-1511965, 82920000, -2604557, 1082626, 12737374, 8165695, -370352]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 1, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            -253390113, -284568126, -284568126, 1082626, 12737374, 8165695, -370352,
        ]
            .span(),
    };
    let tree_3 = xgb_inference::Tree {
        base_weights: array![378677, 3125403, -107056140, 65823, 10777003, -15445928, -4971084]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 0, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            278711724, 201900992, -17005054, 65823, 10777003, -15445928, -4971084,
        ]
            .span(),
    };
    let tree_4 = xgb_inference::Tree {
        base_weights: array![-7683619, 118146656, -9206824, 4767899, 20000866, 12624867, -1052192]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 2, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            -284568126, 88309239, -284568126, 4767899, 20000866, 12624867, -1052192,
        ]
            .span(),
    };
    let tree_5 = xgb_inference::Tree {
        base_weights: array![754412, -1163648, 51852389, 228515, -6351508, -7113041, 6571762]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 1, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            219562465, 163568706, -329629420, 228515, -6351508, -7113041, 6571762,
        ]
            .span(),
    };
    let tree_6 = xgb_inference::Tree {
        base_weights: array![942403, 38257614, -1753996, 763442, 8955361, -4833913, 73722].span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 1, 1, 0, 0, 0, 0].span(),
        split_conditions: array![
            -154847328, -179516482, -113766047, 763442, 8955361, -4833913, 73722,
        ]
            .span(),
    };
    let tree_7 = xgb_inference::Tree {
        base_weights: array![-927579, 2029862, -107579984, 9449647, 12791, -12148368, -3000890]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 0, 1, 0, 0, 0, 0].span(),
        split_conditions: array![
            278711724, -253390113, 88309239, 9449647, 12791, -12148368, -3000890,
        ]
            .span(),
    };
    let tree_8 = xgb_inference::Tree {
        base_weights: array![-1591850, 448939, -103432334, -175194, 7843916, -3076218, -12252869]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 0, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            278711724, 201900992, -56817805, -175194, 7843916, -3076218, -12252869,
        ]
            .span(),
    };
    let tree_9 = xgb_inference::Tree {
        base_weights: array![5117344, -43402221, 6574712, 5371164, -12044235, 11316419, 574643]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![2, 2, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            -214795438, -259504329, -214530241, 5371164, -12044235, 11316419, 574643,
        ]
            .span(),
    };
    let tree_10 = xgb_inference::Tree {
        base_weights: array![3665159, -11298087, 10868479, 126915, -4149118, 156505, 2456507]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 1, 2, 0, 0, 0, 0].span(),
        split_conditions: array![-30271050, -55894756, 21224620, 126915, -4149118, 156505, 2456507]
            .span(),
    };
    let tree_11 = xgb_inference::Tree {
        base_weights: array![6006426, 39090413, 3387443, 136741, 6729720, -7610844, 543364].span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 2, 1, 0, 0, 0, 0].span(),
        split_conditions: array![
            -154847328, -28716521, -134955792, 136741, 6729720, -7610844, 543364,
        ]
            .span(),
    };
    let tree_12 = xgb_inference::Tree {
        base_weights: array![1013871, 2760751, -85583408, 47623, 6506156, -13512765, -225725]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 0, 1, 0, 0, 0, 0].span(),
        split_conditions: array![349219904, 201900992, 88309239, 47623, 6506156, -13512765, -225725]
            .span(),
    };
    let tree_13 = xgb_inference::Tree {
        base_weights: array![332035, 3295560, -26894336, 103090, 19836470, -16402319, -1471987]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 1, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            159485630, 155909417, -253390113, 103090, 19836470, -16402319, -1471987,
        ]
            .span(),
    };
    let tree_14 = xgb_inference::Tree {
        base_weights: array![945292, 129939369, -415028, 4881245, 18666005, -7249908, 133006]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 2, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            -284568126, 88309239, -239961360, 4881245, 18666005, -7249908, 133006,
        ]
            .span(),
    };
    let tree_15 = xgb_inference::Tree {
        base_weights: array![217456, 2589389, -23251321, -18780, 11277191, -14825503, -1187239]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 1, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            163568706, 139920654, -253390113, -18780, 11277191, -14825503, -1187239,
        ]
            .span(),
    };
    let tree_16 = xgb_inference::Tree {
        base_weights: array![-2177725, -394948, -61459668, -251017, 6828949, -8406746, -87917]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 0, 1, 0, 0, 0, 0].span(),
        split_conditions: array![278711724, 201900992, 88309239, -251017, 6828949, -8406746, -87917]
            .span(),
    };
    let tree_17 = xgb_inference::Tree {
        base_weights: array![-4163197, -69467200, -2062367, -554753, -10073359, -1083152, 823938]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![2, 2, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            -214795438, -259504329, 16248496, -554753, -10073359, -1083152, 823938,
        ]
            .span(),
    };
    let tree_18 = xgb_inference::Tree {
        base_weights: array![-462004, 117641688, -2527664, 7823197, 17705000, -50093, -6801692]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 2, 0, 0, 0, 0, 0].span(),
        split_conditions: array![
            -253390113, 107854330, 278711724, 7823197, 17705000, -50093, -6801692,
        ]
            .span(),
    };
    let tree_19 = xgb_inference::Tree {
        base_weights: array![-710632, 1182977, -92461824, -128405, 9456500, -4084084, -16488319]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 0, 1, 0, 0, 0, 0].span(),
        split_conditions: array![
            278711724, 201900992, -40742086, -128405, 9456500, -4084084, -16488319,
        ]
            .span(),
    };
    let tree_20 = xgb_inference::Tree {
        base_weights: array![3898643, 115089464, 3054965, 437250, 16826170, 956662, -1023814]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 2, 2, 0, 0, 0, 0].span(),
        split_conditions: array![-329629420, 88309239, 39273778, 437250, 16826170, 956662, -1023814]
            .span(),
    };
    let tree_21 = xgb_inference::Tree {
        base_weights: array![493600, 109334994, -317859, 15984861, 415388, -942690, 1025422].span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 1, 1, 0, 0, 0, 0].span(),
        split_conditions: array![-329629420, -48527959, 9412916, 15984861, 415388, -942690, 1025422]
            .span(),
    };
    let tree_22 = xgb_inference::Tree {
        base_weights: array![-1891133, -7797273, 13968241, 2726843, -1199665, 2878433, -1868937]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 1, 1, 0, 0, 0, 0].span(),
        split_conditions: array![
            56344327, -149489232, 159485630, 2726843, -1199665, 2878433, -1868937,
        ]
            .span(),
    };
    let tree_23 = xgb_inference::Tree {
        base_weights: array![-751731, 67095732, -1589567, -5438734, 16621357, -7953075, -21475]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![2, 2, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            -284568126, -329629420, -239961360, -5438734, 16621357, -7953075, -21475,
        ]
            .span(),
    };
    let tree_24 = xgb_inference::Tree {
        base_weights: array![4997029, 88708310, 3322867, 5781900, 15246675, -7001017, 517568]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 2, 0, 0, 0, 0, 0].span(),
        split_conditions: array![
            -253390113, 107854330, -207858035, 5781900, 15246675, -7001017, 517568,
        ]
            .span(),
    };
    let tree_25 = xgb_inference::Tree {
        base_weights: array![-3081565, 124117713, -4011581, -2820597, 21438254, -3779249, -12412]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![2, 1, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            -284568126, 54964848, -111773861, -2820597, 21438254, -3779249, -12412,
        ]
            .span(),
    };
    let tree_26 = xgb_inference::Tree {
        base_weights: array![-6491204, 9089222, -14864671, 1795242, -3846003, 14484963, -1605904]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![2, 0, 0, 0, 0, 0, 0].span(),
        split_conditions: array![
            -27633304, 104798735, -329629420, 1795242, -3846003, 14484963, -1605904,
        ]
            .span(),
    };
    let tree_27 = xgb_inference::Tree {
        base_weights: array![-12083, 812897, -83950719, 9190806, -9105, -1715653, -14216664].span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 1, 1, 0, 0, 0, 0].span(),
        split_conditions: array![
            406230677, -259504329, -66678328, 9190806, -9105, -1715653, -14216664,
        ]
            .span(),
    };
    let tree_28 = xgb_inference::Tree {
        base_weights: array![5583516, -19242892, 8388836, -3539364, 10089110, 3725466, 370853]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 2, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            -132462783, 92993159, -92957279, -3539364, 10089110, 3725466, 370853,
        ]
            .span(),
    };
    let tree_29 = xgb_inference::Tree {
        base_weights: array![409541, -1197024, 52722673, 13256715, -187993, 2732802, 16603191]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 0, 0, 0, 0, 0, 0].span(),
        split_conditions: array![
            219562465, -329629420, 65593926, 13256715, -187993, 2732802, 16603191,
        ]
            .span(),
    };
    let tree_30 = xgb_inference::Tree {
        base_weights: array![2780439, -7049063, 13512275, 76248, -3945698, 462836, 3689189].span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 0, 0, 0, 0, 0, 0].span(),
        split_conditions: array![8435321, 96917625, 46622905, 76248, -3945698, 462836, 3689189]
            .span(),
    };
    let tree_31 = xgb_inference::Tree {
        base_weights: array![-393513, 9382670, -10072871, 8739154, 778357, -6240110, -315511]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 0, 0, 0, 0, 0, 0].span(),
        split_conditions: array![3040451, -284568126, 11920764, 8739154, 778357, -6240110, -315511]
            .span(),
    };
    let tree_32 = xgb_inference::Tree {
        base_weights: array![-3220474, 7188420, -8050910, 146163, 9219167, -4646640, -106168]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![2, 2, 2, 0, 0, 0, 0].span(),
        split_conditions: array![-33649600, -37068415, -9817710, 146163, 9219167, -4646640, -106168]
            .span(),
    };
    let tree_33 = xgb_inference::Tree {
        base_weights: array![-700577, -3698116, 17141691, 12158418, -441575, 5579814, -1383435]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 0, 0, 0, 0, 0, 0].span(),
        split_conditions: array![
            118331825, -329629420, -31955092, 12158418, -441575, 5579814, -1383435,
        ]
            .span(),
    };
    let tree_34 = xgb_inference::Tree {
        base_weights: array![3056522, -19554130, 6115618, 3039962, -3807897, 8742653, 312218]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![2, 1, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            -111773861, -77132450, -92957279, 3039962, -3807897, 8742653, 312218,
        ]
            .span(),
    };
    let tree_35 = xgb_inference::Tree {
        base_weights: array![732670, -26355762, 3895903, -1287068, -15461763, 8333464, 121478]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 0, 0, 0, 0, 0, 0].span(),
        split_conditions: array![
            -132462783, -134955792, -105332969, -1287068, -15461763, 8333464, 121478,
        ]
            .span(),
    };
    let tree_36 = xgb_inference::Tree {
        base_weights: array![649858, 68770784, -734957, 4545449, 11599239, -4063389, 302487].span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 2, 0, 0, 0, 0, 0].span(),
        split_conditions: array![
            -253390113, 107854330, -132462783, 4545449, 11599239, -4063389, 302487,
        ]
            .span(),
    };
    let tree_37 = xgb_inference::Tree {
        base_weights: array![-1049756, 2777527, -27896285, -106494, 3354455, -6294320, -1517244]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 0, 1, 0, 0, 0, 0].span(),
        split_conditions: array![
            130905329, 78065961, -76860665, -106494, 3354455, -6294320, -1517244,
        ]
            .span(),
    };
    let tree_38 = xgb_inference::Tree {
        base_weights: array![4054129, 37197299, 1459489, 1402108, 7384738, -3570218, 494252].span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 1, 1, 0, 0, 0, 0].span(),
        split_conditions: array![
            -149489232, -179516482, -93808030, 1402108, 7384738, -3570218, 494252,
        ]
            .span(),
    };
    let tree_39 = xgb_inference::Tree {
        base_weights: array![5619165, -16486784, 9695515, -26659, -4449137, 1127161, -4672006]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 0, 0, 0, 0, 0, 0].span(),
        split_conditions: array![
            -88996726, 34454314, 237007793, -26659, -4449137, 1127161, -4672006,
        ]
            .span(),
    };
    let tree_40 = xgb_inference::Tree {
        base_weights: array![-3256714, -4874575, 33003641, 920257, -916321, 10005696, -2393938]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 1, 0, 0, 0, 0, 0].span(),
        split_conditions: array![
            201900992, -55894756, 237007793, 920257, -916321, 10005696, -2393938,
        ]
            .span(),
    };
    let tree_41 = xgb_inference::Tree {
        base_weights: array![285328, 10249481, -472483, -2155395, 290190].span(),
        left_children: array![1, 0, 3, 0, 0].span(),
        right_children: array![2, 0, 4, 0, 0].span(),
        split_indices: array![0, 0, 1, 0, 0].span(),
        split_conditions: array![-284568126, 10249481, -93808030, -2155395, 290190].span(),
    };
    let tree_42 = xgb_inference::Tree {
        base_weights: array![-2822528, 10476873, -3346874, -206355, -4188544].span(),
        left_children: array![1, 0, 3, 0, 0].span(),
        right_children: array![2, 0, 4, 0, 0].span(),
        split_indices: array![0, 0, 0, 0, 0].span(),
        split_conditions: array![-329629420, 10476873, 237007793, -206355, -4188544].span(),
    };
    let tree_43 = xgb_inference::Tree {
        base_weights: array![-1715051, 34942733, -3866806, -163616, 7900101, -3996583, -203586]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 0, 0, 0, 0, 0, 0].span(),
        split_conditions: array![
            -163314512, -207858035, -132462783, -163616, 7900101, -3996583, -203586,
        ]
            .span(),
    };
    let tree_44 = xgb_inference::Tree {
        base_weights: array![-319434, 72010109, -1679615, 9218906, -2453179, -6694187, -6137]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 1, 0, 0, 0, 0, 0].span(),
        split_conditions: array![
            -253390113, 406230677, -207858035, 9218906, -2453179, -6694187, -6137,
        ]
            .span(),
    };
    let tree_45 = xgb_inference::Tree {
        base_weights: array![144713, 4639108, -18065202, 149581, 7778706, -4119266, -193448].span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![2, 2, 2, 0, 0, 0, 0].span(),
        split_conditions: array![94258125, 78065961, 142498992, 149581, 7778706, -4119266, -193448]
            .span(),
    };
    let tree_46 = xgb_inference::Tree {
        base_weights: array![1631614, 2488379, -48293862, 111002, 3396329, 4318487, -7073779]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![0, 0, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            349219904, 200281154, -56817805, 111002, 3396329, 4318487, -7073779,
        ]
            .span(),
    };
    let tree_47 = xgb_inference::Tree {
        base_weights: array![-384613, 2837460, -32086468, 126364, 11873236, -4011036, 301692]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 1, 1, 0, 0, 0, 0].span(),
        split_conditions: array![
            159485630, 155909417, 278711724, 126364, 11873236, -4011036, 301692,
        ]
            .span(),
    };
    let tree_48 = xgb_inference::Tree {
        base_weights: array![-897263, 1411189, -21246928, -101522, 7694288, -13693835, -1155426]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![1, 1, 2, 0, 0, 0, 0].span(),
        split_conditions: array![
            159485630, 133199606, -253390113, -101522, 7694288, -13693835, -1155426,
        ]
            .span(),
    };
    let tree_49 = xgb_inference::Tree {
        base_weights: array![-2298299, 2201477, -14104804, -593803, 2224070, 4869009, -1871098]
            .span(),
        left_children: array![1, 3, 5, 0, 0, 0, 0].span(),
        right_children: array![2, 4, 6, 0, 0, 0, 0].span(),
        split_indices: array![2, 2, 0, 0, 0, 0, 0].span(),
        split_conditions: array![56344327, 9412916, -179516482, -593803, 2224070, 4869009, -1871098]
            .span(),
    };
    let num_trees: u32 = 50;
    let base_score: i32 = 9193636;
    let opt_type: u8 = 0;
    let trees: Span<xgb_inference::Tree> = array![
        tree_0,
        tree_1,
        tree_2,
        tree_3,
        tree_4,
        tree_5,
        tree_6,
        tree_7,
        tree_8,
        tree_9,
        tree_10,
        tree_11,
        tree_12,
        tree_13,
        tree_14,
        tree_15,
        tree_16,
        tree_17,
        tree_18,
        tree_19,
        tree_20,
        tree_21,
        tree_22,
        tree_23,
        tree_24,
        tree_25,
        tree_26,
        tree_27,
        tree_28,
        tree_29,
        tree_30,
        tree_31,
        tree_32,
        tree_33,
        tree_34,
        tree_35,
        tree_36,
        tree_37,
        tree_38,
        tree_39,
        tree_40,
        tree_41,
        tree_42,
        tree_43,
        tree_44,
        tree_45,
        tree_46,
        tree_47,
        tree_48,
        tree_49,
    ]
        .span();
    let mut result: i32 = xgb_inference::accumulate_scores_from_trees(
        num_trees, trees, input_vector, 0, 0,
    );

    if opt_type == 1 {// Implement logic here
    } else {
        result = result + base_score;
    }

    return result;
}

#[executable]
fn main(
    return_lag_1: i32, return_lag_2: i32, return_lag_3: i32, is_first_parameter_negative: u8,
) -> i32 {
    let mut input_vector = ArrayTrait::new();

    let return_lag_1_check = if is_first_parameter_negative == 1 {
        -return_lag_1
    } else {
        return_lag_1
    };

    input_vector.append(return_lag_1_check);
    input_vector.append(return_lag_2);
    input_vector.append(return_lag_3);
    let result = predict(input_vector.span());
    println!("Inference result: {}", result);
    let predict = if result > 0 {
        1
    } else {
        2
    };
    predict
}
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let mut input_vector = ArrayTrait::new();
        input_vector.append(46896864);
        input_vector.append(19840426);
        input_vector.append(-48111976);
        let result = predict(input_vector.span());
        println!("Inference result: {}", result);
        assert(result == 15654362, 'BTC model works!');
    }
}
