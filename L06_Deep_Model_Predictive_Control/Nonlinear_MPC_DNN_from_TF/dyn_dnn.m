function nextState = dyn_dnn(state, action)
%
%   Signature   : nextState = dyn_dnn(state, action, Par)
%   Inputs      : state -> State, consisting of concatenation of cell states
%                          and hidden states
%                 action -> Input vector 
%                 Params -> Struct containing all required weights and
%                           biases
% 
%   Outputs     : nextState -> Updated states
% 
%-------------------------------------------------------------------------%

%% Hard coded matrices here
WFc1 = [-0.23699689,1.4079512;-0.061211221,0.0069744331;-0.12360343,-0.0047822297;-0.029840618,-0.23849979;-0.54018229,1.5070763;0.0081727346,1.5277876;0.10131659,1.0168731;0.18797466,1.3411226;-0.22993186,-0.22042617;-0.38468838,1.4940253;-0.53896511,1.5702704;-0.32996920,0.82202780;-0.46012715,1.5129043;-0.088895813,1.3380213;-0.080610096,1.3091679;0.074041329,0.89830637;-0.55401200,1.4711337;0.0024395268,-0.16289148;-0.45632717,1.2696184;-0.25261474,-0.029208660;0.037441965,1.5217881;-0.26552323,1.4043887;-0.32971090,-0.14831448;-0.11973501,1.4494587;-0.0084395567,1.2350109;-0.13698906,-0.25638843;-0.066231333,1.4259183;-0.24312298,-0.13606992;0.18038464,1.0375137;-0.049887717,-0.15531707;-0.22265336,1.1543835;-0.43880364,1.4219538];
WFc2 = [1.1589357,-0.098734781,0.053058922,-0.017893702,1.4019659,0.67176890,1.1840751,0.55122256,0.19822648,1.1035640,1.1247299,0.85066736,1.2984567,0.94199413,1.3150940,0.60141796,1.0458168,0.31501111,0.74250108,-0.079571307,1.2200429,1.3876463,-0.14042041,0.88437569,1.0591102,0.24511132,1.1422297,-0.33113530,0.63539416,-0.091061711,1.0198046,1.2015481;1.0461656,-0.21599528,0.13125280,0.25786445,1.5157429,1.2056694,1.0926192,1.0935925,0.30499592,0.90883726,1.0516852,1.3285290,1.0974793,1.3369949,1.3411903,0.85703057,1.4151013,0.25913996,1.2536130,-0.10415170,0.91639334,0.93659508,-0.23612180,0.75002640,1.1693376,0.075266689,1.0363021,-0.049831569,0.57136929,-0.26478353,0.92896372,1.3948203;0.27162328,-0.055666726,0.18365529,-0.21000315,0.090769477,0.26100034,-0.31643701,-0.12330443,0.29438421,-0.19134761,0.21012600,-0.25282225,-0.10564786,-0.24928580,-0.13721186,-0.029870005,-0.18753394,0.18627168,-0.16964275,-0.10533550,-0.18138714,-0.14686561,-0.060675621,0.28510493,-0.13814709,-0.28093857,-0.17782634,-0.35332513,0.15983962,0.046914935,0.28331050,0.28207174;-0.21637671,0.26893520,0.28916708,-0.27260059,-0.027351314,-0.047085430,0.21703911,0.15940283,0.17057815,0.060544048,0.16453448,0.23577285,0.016025536,0.10945964,0.098812379,-0.13288739,-0.17067122,-0.080855541,-0.31801602,0.23930219,-0.28754890,0.30133396,-0.12048014,0.065789834,0.042737689,-0.065465271,-0.21852106,-0.25766483,-0.24638224,-0.16745263,0.15189938,0.065573350;0.16345051,-0.25594532,-0.064345181,-0.10535717,0.088649988,0.25856659,-0.037991077,-0.30097678,-0.11824130,0.23371407,-0.23443738,0.15757141,-0.28256992,-0.10293254,0.098426282,0.25549975,-0.34815630,0.28608701,0.011420697,-0.15564696,-0.27064076,-0.11513355,0.036852866,0.16070887,-0.13446496,-0.075627387,0.085184246,-0.10462441,-0.13760862,0.043207765,-0.027707428,0.26328698;0.25908875,-0.26715925,0.26623657,0.12888566,0.25831738,0.12456843,-0.13899878,-0.042954892,0.28148946,-0.23125882,-0.012283084,0.041838963,-0.19528101,-0.26397640,-0.0044755028,0.22792600,0.10788396,-0.050069410,-0.13413057,0.17816630,-0.10919774,0.040077623,-0.26933748,0.11809744,0.10591798,-0.0090616643,-0.34822109,-0.059172750,0.31690583,0.053789914,-0.20892742,-0.33033469;0.29350626,0.046449531,0.027506620,-0.22550435,-0.25624266,0.0015870464,-0.060369998,-0.095334940,-0.11138695,-0.10471664,0.0025369220,0.0011798367,-0.16765296,0.0077677066,0.19818783,-0.37351134,0.30500007,-0.047907278,0.061307292,-0.066499799,-0.28093150,0.10024704,-0.30096054,-0.063243523,-0.042503726,0.20189658,0.038281385,-0.23349969,0.23935437,0.11953065,0.21870834,-0.10356215;0.14865485,0.30537519,-0.051384777,0.22369185,-0.29114205,-0.13720673,0.15432908,-0.079063736,0.053779542,-0.13126543,0.20076765,-0.32036811,-0.33308181,-0.039853964,-0.073978484,0.15465434,0.23799050,0.024343802,-0.27084982,0.20824233,0.038834091,-0.26137462,-0.35259217,0.21980883,0.31933931,-0.022161245,0.19754148,0.27053347,-0.20873909,-0.19176631,-0.22663796,-0.28651845;-0.10659191,0.29603627,-0.069881231,0.11067390,0.072899312,0.084681593,0.073599674,-0.19363526,0.34993938,-0.057922278,-0.16465130,-0.33771721,0.20672366,-0.026547594,0.13964616,0.20735738,-0.26001894,0.26183727,-0.16473635,0.10813281,-0.24230441,-0.12513129,0.16544333,0.067444049,0.29477599,0.016410142,0.13819322,-0.34718677,-0.23624127,0.32935002,-0.26899964,-0.15446806;-5.6571371e-05,0.054556958,0.11754411,0.30110416,-0.0046521835,0.20466600,-0.037171554,0.12193833,0.095445573,0.22360913,0.13712917,-0.048768796,0.25781575,-0.26540852,-0.31927654,0.16599786,-0.11204170,0.20629591,0.10180401,-0.17606694,-0.34730801,-0.28531650,0.28060815,-0.13204163,0.14558685,0.11113515,-0.23621836,-0.16440617,-0.079558983,-0.096414208,0.31678858,0.22527319;0.86332083,0.093097985,-0.23795512,-0.18443359,1.2516090,0.88175130,1.2280886,0.81488669,0.28847125,1.4062887,1.0359018,1.0160698,1.3220878,1.1771262,0.84885865,0.86141109,1.1850227,-0.29479364,0.91552311,-0.17433782,1.2396080,1.1691085,0.061159968,1.1983385,1.0865203,0.33650783,0.84680074,0.12033033,1.1771188,0.16861776,1.0569201,0.99604493;0.12009557,0.21233442,-0.22471680,0.23800912,-0.027993595,-0.16603355,-0.25466380,0.0087683387,0.12979382,-0.018714193,0.063687205,-0.34189606,0.013414123,0.24266352,0.10343665,0.14057618,0.058855608,-0.23506965,0.28155297,0.081013501,-0.31737000,-0.32503715,-0.049212009,0.32379857,-0.31239980,-0.21141610,-0.18447821,-0.056934237,0.31134769,0.16802648,0.020780211,0.23722620;0.71101302,0.24986114,0.33262429,-0.31985784,1.3309928,1.1244746,1.1331711,1.1306581,-0.11179636,0.89691842,0.90675378,0.81395745,0.89361954,0.88575798,0.74489260,1.0601619,1.3438728,-0.33284783,0.82927668,-0.040524036,1.1421257,0.75019264,0.14950600,1.0280558,0.80134249,-0.32215104,1.1547213,0.0051215291,1.0835289,-0.19578037,0.60081816,1.0326136;0.024638027,0.27689233,-0.31013894,0.21263811,-0.20810175,-0.20819935,-0.14340068,0.0080275536,-0.091874659,0.092846990,0.29814467,0.099186867,0.059095114,0.29622522,-0.26244169,-0.18168418,-0.21360655,-0.082321733,-0.27837479,0.13018420,-0.11795807,-0.15748297,0.17249903,0.26222590,0.15752956,0.20370397,-0.25248271,0.30246881,-0.12468512,0.19470093,-0.11140575,-0.34203759;1.1909679,-0.32917207,0.021458894,0.23329344,0.93945611,0.85415840,0.66251409,1.1826141,-0.082382172,1.3971816,1.4923694,0.80642688,1.3299303,1.2280380,1.0703859,0.62584925,1.0563610,0.10537326,1.1314950,0.042274296,1.0075977,0.70790964,-0.21668530,0.86636668,0.89531010,0.22022060,0.81330311,0.19023529,1.0000080,0.23230669,0.73353523,1.2487103;0.24091835,-0.0083116572,0.34436056,-0.25223649,-0.27268988,0.039639063,0.038821571,-0.30378333,0.32652143,0.015808916,-0.18749914,-0.091262162,-0.20339540,0.11941910,-0.23017886,-0.24889702,-0.15366001,-0.25845972,0.050934739,0.075713873,-0.14654242,0.32627517,0.042948902,0.29158169,-0.082631446,0.16387960,-0.035078801,-0.10628904,-0.36447921,0.10344732,0.077165678,-0.14548999];
WFc3 = [1.3844097,1.2373246,-0.54808122,-0.15970902,0.012639403,-0.12898837,-0.48899090,-0.54856753,-0.24341619,-0.0084032612,1.2989439,-0.49308708,1.5767556,-0.34643617,1.3383405,-0.027829567];

bFc1 = [0.86021334;-0.015169384;0;0;0.96874630;0.96601921;0.92822236;0.93082970;0;0.99864811;0.89637673;0.86019003;1.0032275;0.95065886;0.96942574;0.91861033;1.0140512;-0.014498397;0.85685760;0;0.87616628;0.92839926;0;0.90636569;0.97476602;0;0.94855165;0;0.95845491;0;0.75458920;0.94972312];
bFc2 = [0.73399901;0.77630812;-0.032742724;-0.042092990;0;-0.020353623;-0.022034001;-0.029936664;-0.0094590290;-0.030740526;0.74156338;-0.019845236;0.66991538;0;0.75053507;-0.024241174];
bFc3 = [0.53594613];
%% Computation

% Layer 1 - Fully connected
ZFc1 = ReLu_function(WFc1 * action + bFc1);

% Layer 1 - Fully connected
ZFc2 = ReLu_function(WFc2 * ZFc1 + bFc2);

% Layer 1 - Fully connected
ZFc3 = ReLu_function(WFc3 * ZFc2 + bFc3);

nextState = [ZFc3];



end



%% Auxiliary functions
function y = ReLu_function(x)
y = max(0,x);
% if x < 0
%    y = 0;
% else
%     y = x;
% end

end