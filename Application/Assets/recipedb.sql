--
-- PostgreSQL database dump
--

-- Dumped from database version 10.15 (Ubuntu 10.15-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.15 (Ubuntu 10.15-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (8, '2017-11-30', '2018-01-12 17:52:31.287', 'A541D46094756FC03D4CF33FD18D1CF37424E3E61CAED22005D5EBB4D1B5ABAF30CEBA0BFB1F23AAEFB54E3AD3D6B7773C20D15BAD590C893FC5B76F3E05A6F4', '5FF4A2D72BCBF1C9CB6C85F46B6A5EBAD4721B0BB741679185406C2126AB21B63447FF2128BD266760F530B31F7949A415F0AD846FA3D84170D9217117D16434', '', 'birgitte', 'Birgitte Pugh', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', false);
INSERT INTO public.users VALUES (6, '2017-11-30', '1666-06-06 06:06:06', 'BCFC72B2A25A184CB0042EA5F7B3F7978AED8AD26FE7BB0B35C31F9F1165875634F6B71297A74DB85FDBA9A4E3E3CE42D8B579E0B85220F69CDEE1040FF262BD', '8D62209BCFA61556F0EB16C899CDE60D89A0E79F8F7BE98EC5E1161E60CF49B88C492ED8D43A6DBFD4BEDB8859FC46C36824F0B86CC3B30249A0CD836B2F39BA', '', 'joris', 'Joris Wiselius', 0, '', false);
INSERT INTO public.users VALUES (2, '2017-10-25', '2018-07-09 08:59:57.77', '5121CE9E954C6DB66B9E6C03C43D2555619CD9683D8A5358489B989C76CFECE162FFEB8A4A13E76941DCD8787843809867BDBB3B3D529FD49891B74923CE546B', '3C8559D2341C467F5F1EB41D3859993FDA7E03C2180C9ACF125B66C2DD6C32632D9AFB767D4B56D7527FDCF2C0D65E54061635EE3D77C5DCB438B14080785F84', '', 'katja', 'Katja', 31, 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', false);
INSERT INTO public.users VALUES (4, '2017-11-30', '2017-11-30 12:33:00.679', 'DBBCA5CB267F8F57815C4BB84C066276F3B76B6A74CFE02CAA3F4ECAFF24806BA6C29F782A8723F1416F3FEBA7BA190C4C1BB0D41F7F6B5A83BD815E4E30D085', '51340EE09508E5A79E07EBB88C37DD79612988D17BF8298CE52FEDF122287C9AFF3617A444520D8FED78BF5E5532D577C8322D98CF698587D1EF2980CFDEDE63', '', 'henrik', 'Henrik Nørgaard', 2, 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36', false);
INSERT INTO public.users VALUES (9, '2017-11-30', '1666-06-06 06:06:06', '552D1C924DD7013144B2807FDC83295014097268768A1218D8BEA602DEE1CA88482BB7B7B42FA0045BFB0D82152C32168ABB28F0B27E11376A3812BF78C4434D', '83B900265755A1DA45F8533BBB3F06769EFDEB4082BC36967FC61A3762788F5C0C64408CCCBF33FA00B69B87282DD31AC40D4E6A00094E2A1C03EE08F4485E7D', '', 'brett', 'Brett Payne-Rhodes', 0, '', false);
INSERT INTO public.users VALUES (7, '2017-11-30', '2018-01-12 14:37:43.675', '0CF75240F6D5F4390AAC5D06DE3985990F64B7AB33C90F04665DEADC8AED29B1EB658DA2582C6800A7143916205F01380ED703E57EC44CDC2CD023E0120AC5B4', '7966769FF78BE1A07F14E4F31C99BBEF09D6F3FB712025E5364BC11E111747DEA45C5293983135ED11CC65760C3B4EFAF8E670F0EB6BD751736E96A870A079B4', '', 'mkaalund', 'Michael Kaalund', 1, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36', false);
INSERT INTO public.users VALUES (5, '2017-11-30', '2018-01-12 15:08:45.439', 'B477BF062FAAD9737EB10E2469D1F8D89CE8E538FCFDBCF9AEF94796603981E4E7E0B54176F4314BA10F45F071531058FDF975884EC9EB3C849034B0460E1113', 'ADCEC4CE3E556341B500940298E785E13B2420F147090865687BFDF8BA9B9A162046CBE1FB5623F2BB6F271E6CB4342936E7F8A9C306A94BFA907B6908F037BB', '', 'marcus', 'Marcus Wischik', 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36 Edge/16.16299', false);
INSERT INTO public.users VALUES (3, '2017-10-25', '2019-11-30 20:21:10.67', '8E436C9E37987A8D1704D74740CCEECCCDD52A1641602AF99F46FA8F144AC510817E094E578E8F0126E8AC6EF2B14468F2F4D471004BAA6552F567104C67E45C', '817EBCD4E75B0DB6F9B836DC3C9649C22E70EFAE58BE22FF7DA9CF7E8D8AED4BE7B604E6961E3D10CBBC3DBB33DC02D81D9DEC9EFCE5038A331AA9BF22BA78F1', '', 'carlette', 'New user XYZ72', 4, 'Mozilla/5.0 (Linux; Android 9; H8314) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Mobile Safari/537.36', false);
INSERT INTO public.users VALUES (1, '2017-10-25', '2020-05-01 12:31:59.29', '049900C1B53A842AE0621A71E23C61CA801DDCDFF9E2BC1B2F39D9206A8649873E5465C568000ADCFC7ECDD9990A2F568128B4C1470E6F1D401D93779B62B4E8', '7EFFE0C3F278C9D70272F82795C68C76F54E9D2E654D7A83F80951C1212D22C4B27B6C2A81E904E7677777FBA71803DA94023A2FB1DBF0DB34DFA243B1FC8ECB', '', 'tfrengler', 'Thomas', 107, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36', false);


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.recipes VALUES (2, 'Mushroom Bourguignon', '2017-11-26', '2018-02-16 14:38:44.839', 2, 2, '<p>- neutral oil &amp; olive oil<br />- 2 pounds cremini mushrooms, trimmed and cut into 1/4-inch slices (around 900 grams)<br />- 1 large yellow onion, diced small<br />- 1 small carrot, peeled and diced small<br />- 3 garlic cloves, minced<br />- 2 generous sprigs fresh thyme<br />(1 fresh sage leaf, minced, optional)<br />- 1 cup good, dry red wine<br />- 2 tablespoons tomato paste (I use one of those small cans)<br />- 2 cups good vegetable broth<br />- Salt and pepper, to taste</p>', '<p>Delicious mushroom stew, nice and rich for the cold autumn/winter days.</p>', 'FB7F77D3-1F49-4B5D-85D51671F68F0D5E', '<p>Brown all the mushroom slices in oil. You want to have quite high heat and not too many in the pan at once (depending on the size of your pan, but 900 grams takes me about 4 goes). You want to get colour and fry them till they are golden and delicious. Set them aside.</p>
<p>Warm some&nbsp;olive oil over medium heat. Add onion and carrot along with 1/2 teaspoon salt and a few grinds black pepper and cook, stirring occasionally, for 10 minutes. Onions and carrots should be lightly browned. Stir in the garlic, thyme (stems and all) and (sage) and cook until very fragrant, a minute or two, the stir in &nbsp;the tomato paste and let it cook for a moment.</p>
<p>&nbsp;</p>
<p>Pour in the wine. Turn heat up to high and simmer briskly until reduced by half. Stir in broth, then add back the mushrooms and all the beautiful accumulated juice from the bowl. If your broth is low-sodium, add an additional 1/2 teaspoon salt. If not, wait and taste at the end. Bring to a boil, and then you can place it into the oven till it is all nice and aromatic. I would say 180 for and half an hour, and then you can lover the heat and let it simmer. You can add more liquid if it looks like it is reducing too much.</p>
<p>Serve with mashed potatoes or whole grain rice.&nbsp;</p>', true);
INSERT INTO public.recipes VALUES (1, 'Spiced Pumpkin Protein Balls', '2017-10-25', '2018-02-16 14:40:27.877', 2, 2, '<p><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">desiccated coconut, for rolling</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">50g (&frac12; cup) rolled oats</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">50g (&frac12; cup) almond meal</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">150g (&frac34; cup) cooked pumpkin, mashed</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">25g (&frac14; cup) pecan halves</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">1 tbsp pure maple syrup</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">&frac12; tsp ground cinnamon</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">&frac12; tsp ground ginger</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">&frac14; tsp allspice</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">pinch of nutmeg</span></p>', '<p><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">Homemade&nbsp;</span><span style="box-sizing: inherit; line-height: inherit; font-weight: bold; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">Spiced Pumpkin Protein Balls Recipe by Kayla Itsines.</span><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">&nbsp;These balls are packed with energy, making them the ultimate snack! (I have never made these, but they sound delicious :) -Katja)</span></p>', 'BE61E254-D07B-49B5-8534684FC5E9291C', '<p><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">1. Line a baking tray with baking paper and place the desiccated coconut on a plate.</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">2. Place the oats in a food processor and blend until a rough crumb forms.</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">3. Add the almond meal, pumpkin, pecans, maple syrup, cinnamon, ginger, allspice and nutmeg and process until well combined. The mixture should be a little sticky, but if it is too thick, try adding 1-2 tablespoons of water.</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">4. Using wet hands, roll tablespoons of the mixture into snack-sized balls.</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">Roll through the desiccated coconut to coat.</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">5. Place the balls on the lined tray and refrigerate for 30 minutes before serving.</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">Enjoy!</span><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><br style="box-sizing: inherit; color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;" /><span style="color: #333333; font-family: ''Open Sans'', sans-serif; font-size: 16px;">*You can store the balls in an airtight container in the refrigerator for up to a week. If they even last that long!</span></p>', true);
INSERT INTO public.recipes VALUES (4, 'No-Bake Energy Bites', '2017-11-26', '2018-01-06 19:19:10.889', 1, 1, '<ul>
<li>1 cup (dry) oatmeal (I used old-fashioned oats)</li>
<li>2/3 cup toasted coconut flakes</li>
<li>1/2 cup peanut butter</li>
<li>1/2 cup ground flax seeds</li>
<li>1/2 cup semisweet chocolate chips (or vegan chocolate chips)</li>
<li>1/3 cup honey or agave nectar</li>
<li>1 tablespoon chia seeds (optional)</li>
<li>1 teaspoon vanilla extract</li>
</ul>', '<p>This No-Bake Energy Bites recipe is easy to make, full of feel-good ingredients, and so irresistibly delicious!</p>', '42B3684F-033E-415E-A8C1610E0EB28DDF', '<p>To make the no bake energy bites, just stir all of those ingredients together in a large bowl until combined. (Or if you get tired of using a spoon, just use your hands. That&rsquo;s what I do!)</p>
<p>Once the mixture is combined, pop it in the fridge for 10-20 minutes so that it will harden slightly. This will help make it easier to roll it into balls.</p>
<p>Then once the mixture has cooled slightly, shape it however you please, and refrigerate in an&nbsp;airtight storage container. &nbsp;I like shaping my energy bites into 1-inch balls, but you can make yours smaller or larger. &nbsp;Or if you&rsquo;d rather, you can&nbsp;press the mixture into a baking dish lined with parchment paper and you make energy bars instead of bites. &nbsp;Whatever sounds good to you!</p>
<p>The best thing about this recipe is that it is&nbsp;super&nbsp;flexible as well. &nbsp;So if you are allergic to any of the ingredients, or if you are just looking for other substitution ideas, feel free to use:</p>
<ul>
<li><strong>Different (or no) chocolate:</strong>&nbsp;I generally use dark chocolate chips. &nbsp;But you can also substitute in any other kinds of chips (butterscotch, milk chocolate, white chocolate, cinnamon chips, etc.). &nbsp;Or if you are vegan, grab some&nbsp;vegan chocolate chips. &nbsp;Or if you don&rsquo;t dig chocolate, you can leave this part out all together.<br /><br /></li>
<li><strong>Different nut butter:&nbsp;</strong>If you are allergic to peanuts, feel free to substitute in any other kinds of nut butter, like&nbsp;almond butter,&nbsp;sunflower seed butter, cashew butter, or others. &nbsp;(For a great tutorial on homemade nut butters, check out this great post from&nbsp;Tasty Yummies.)<br /><br /></li>
<li><strong>Different sweetener:</strong>&nbsp;I really prefer honey in this recipe. &nbsp;But agave also works and is vegan, and some readers have had success with alternative sweeteners too.</li>
</ul>
<p><br />In general, if you start experimenting with different ingredients or leave some ingredients out entirely, the balance of the recipe may be a little &ldquo;off&rdquo;. &nbsp;So if they get too dry, add a few more of the sticky ingredients like honey and/or peanut butter. &nbsp; If they get too gooey, add in more oats.</p>
<p>The name of the game with this recipe is customization. &nbsp;So feel free to give them a try and keep tweaking them to whatever specific combination tastes and feels good to you. &nbsp;Cheers to more energy bites in our future!</p>', true);
INSERT INTO public.recipes VALUES (5, 'Tykstegsbøffer - Sous Vide', '2018-01-12', '2018-01-12 14:50:00.644', 7, 7, '<p>Tykstegsb&oslash;ffer</p>
<p>Sm&oslash;r - 25g</p>
<p>Salt</p>
<p>Peber</p>
<p>Citronskal</p>
<p>Rosemarinkviste</p>', '<p>Mine eksperimenter med, at tilberede Tykstegsb&oslash;ffer i sous vide.</p>', '', '<p>Sous vide, s&aelig;ttes til 57 grader. B&oslash;fferne l&aelig;gges i vandbadet i 4 timer for rosa.</p>', false);
INSERT INTO public.recipes VALUES (15, 'Easy lentil soup, perfect for a weeknight meal', '2018-02-16', '2018-02-27 18:46:22.449', 2, 2, '<ul>
<li>1 onion</li>
<li>2 cloves of garlic</li>
<li>1/4 teaspoon ground coriander (I also like to add cumin&nbsp;+ curry powder)</li>
<li>1 tablespoon currypaste (Indian (Organic) Madras/Korma curry paste)</li>
<li>1 can of tomatoes (chopped or whole, if using whole ones, just toss them in the pan,&nbsp;<br />and "chop" them with a wooden spatula, no need to cut them, only makes a mess)</li>
<li>1 can of water (use the tomatoe can)</li>
<li>1,5 dl of dried red&nbsp;lentils (100-110 grams)</li>
<li>200 ml of (organic) coconut milk</li>
<li>1/4 teaspoon salt</li>
<li>freshly ground black pepper</li>
</ul>', '<p>This is a super easy lentil soup, which cooks fast thanks to the red lentils. Perfect for a weeknight meal!</p>', '4D5C2139-29AF-4CF7-B1A43AB867AAA007', '<p>Chop the onion and garlic. Add some oil in the pan followed by the curry paste, coriander and onion. Saut&eacute; for a moment. Add the garlic, stir for a moment.<br />Add to saucepan the (crushed) tomatoes, water and lentils. Cook until the lentils are cooked (10-15 mins, if you taste them they should be nice and soft), and add more water if necessary.<br />Add the coconut milk, salt and pepper. Puree until smooth.<br />Bring to boil and serve with&nbsp;bread or salad.</p>', true);
INSERT INTO public.recipes VALUES (6, 'Biochemical Roast Potato', '2018-01-12', '2018-01-12 15:25:06.387', 5, 5, '<ul>
<li>5g of baking soda</li>
<li>2kg of potato (ideally russet)</li>
<li>5tbsp of fat (olive oil, goose fat... whatever)</li>
<li>Some garlic. The amount will vary depending on taste. I use 5 cloves, ground</li>
<li>Some chopped bacon. The amount will vary depending on taste. I use 2-3 rashers.</li>
<li>1 onion, quartered</li>
<li>Salt, pepper, and rosemary to taste</li>
</ul>', '<p>Scientifically optimised for crunchy on the outside, and soft on the inside.</p>
<p>Boiling in alkaline water helps to remove some of the soluble starch from the potato. This improves the roasting of potato.</p>', '51D96FB2-FB3B-4C5B-9482FA37F8BCAFEF', '<p>1) Chop potatoes into large chunks</p>
<p>2) Put the baking soda in a large pot, and then boil for 10-15 minutes. The potoat should be soft enough that you can put a knife into it with limited resistance.&nbsp;</p>
<p>3) Drain potatoes</p>
<p>4) Combine the remaining ingredients in a sealed box and shake vigourosly. The aim is to cover the potatoes with the other ingredients, and also to slightly "rough up" the potato.</p>
<p>5) Transfer the roughed-up potato to a baking sheet</p>
<p>6) Set oven to 200 degrees C and cook. After 20 minutes, take pan out and separate any that are stuck together, turn them, and if necessary sprinkle with more fat.</p>
<p>7) Return to oven and cook for another 20-30 minutes, depending on taste.</p>
<p>8) Serve and enjoy</p>
<p>&nbsp;</p>', true);
INSERT INTO public.recipes VALUES (16, 'Broccoli couscous', '2018-02-16', '2018-02-16 14:35:59.728', 2, 2, '<ul>
<li>1 medium broccoli</li>
<li>1 tsp cumin</li>
<li>salt and pepper</li>
<li>200 grams of frozen peas</li>
<li>a handful of parsley</li>
<li>2 spring onions</li>
<li>100 grams roasted and salted almonds</li>
<li>pomegranate seeds (1 pomegranate)</li>
</ul>
<p>Dressing:&nbsp;</p>
<p>Dressing:</p>
<ul>
<li>Grated zest of 1 lemon</li>
<li>Lemon juice (whole or half, depending of your taste)</li>
<li>2 tablespoons olive oil</li>
<li>salt</li>
</ul>', '', '28BC3BEC-DF8F-4DE3-ABFD24D3DE85CB6D', '<p>Cut the&nbsp;broccoli&nbsp;stalk off and peel it. Cut the stalk into few pieces and blend/use kitchen mixer.</p>
<p>Cut the rest of the&nbsp;broccoli&nbsp;into big florets and grind them in few batches.</p>
<p>Heat a frying pan and add the oil. Add the&nbsp;broccoli&nbsp;and season with cumin, salt and pepper.&nbsp;<br />Pour the still frozen peas to the pan and fry over medium heat until peas are thawed.<br />Finely chop the parsley and spring onion. Mix them in and move the pan from the heat.<br />Add the pomegranate seeds and mix all ingredients together.<br />Combine sauce ingredients and mix it in.</p>
<p>&nbsp;&nbsp;&nbsp; Who made the recipe recommends eating it warm, but I like eating it cold too.<br />I also like adding the almonds at the last moment, so they don''t get all wet.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>', true);
INSERT INTO public.recipes VALUES (7, 'Black Bean Burgers', '2018-01-12', '2018-01-12 16:04:28.662', 2, 2, '<p>2 cans black beans, rinsed and drained<br />1 onion, minced<br />3 garlic cloves, minced<br />2 carrots, shredded<br />1/2 cup quick oats (blended to make oat flour)<br />1 Tbsp. soy sauce<br />1 Tbsp. olive oil<br />1 tsp cumin<br />1/2 tsp coriander<br />1/2 tsp chili powder<br />1/4 tsp cayenne pepper<br />Salt and pepper to taste<br />Buns (we did not use vegan buns, but you can!)</p>', '<p>The best black bean burgers I have made, the carrot keeps them nice and moist, no dry burgers!</p>
<p>&nbsp;</p>
<p>Original recipe with video:&nbsp;https://www.buzzfeed.com/caroltan/this-is-how-you-make-black-bean-burgers?utm_term=.wckQJP1Kd#.ytO4MLJnK</p>
<p>&nbsp;</p>
<p>Feel free to double the recipe, you will be happy when you find these from your freezed when you want to have something in a hurry.</p>', '54273B5F-983A-46C0-92641CF3DE9E2AC4', '<p>Heat one tablespoon of olive oil in a pan. Combine onions, garlic, salt, and pepper and cook until onions are translucent. Add carrots, cumin, coriander, chili powder, and cayenne pepper until carrots are tender. Remove pan from heat.</p>
<p>In a bowl, mash the beans and then add the contents of the pan along with the soy sauce and quick oats. Mix and form four patties. Place in freezer for 30 minutes to set. Cook patties on a pan coated in cooking spray over medium heat, flipping halfway.</p>
<p>Use patties to create your dream veggie burger.</p>', true);
INSERT INTO public.recipes VALUES (9, 'Mediterrane groentensoep', '2018-01-27', '2018-01-27 17:37:41.842', 1, 1, '<ul>
<li>2 eetl. olijfolie</li>
<li>1 ui, fijngesneden</li>
<li>2 teentjes knoflook, uitgeperst</li>
<li>4 grote, rijpe tomaten, gepeld en fijngehakt</li>
<li>1 rode paprika, vruchtvlees fijngehakt</li>
<li>1 eetl. zongedroogde-tomatenpuree</li>
<li>1&frac14; liter groenten- of kippenbouillon</li>
<li>2 courgettes, overlangs in vieren en dan in schrijfjes</li>
<li>4 theel. kappertjes, afgespoeld en uitgelekt</li>
<li>Handvol basilicumblaadjes, grof gescheurd</li>
<li>Zout en versgemalen zwarte peper</li>
</ul>', '<p>Deze rijke tomatenbouillon, gevuld met kappertjes, is een heerlijke gezonde, lichte soep voor de zomer en vroege herfst als deze groeten op hun best zijn</p>', '', '<p>Verhit de olie in een grote pan. Doe er ui en knoflook in en smoor ze 5 minuten. Voeg de tomaten, paprika, tomatenpuree en bouillon toe en breng hem aan de kook. Draai het vuur laag, zet het deksel op de pan en laat de soep 10 minuten zachtjes koken.</p>
<p>Doe de courgette en kappertjes in de pan en laat de soep nog 10 minuten pruttelen. Roer het het basilicum door de soep, breng hem op smaak met zout en peper. Schep hem in diepe borden of kommen en dien hem op.</p>', true);
INSERT INTO public.recipes VALUES (8, 'Gekruide linzensoup met kikkererwten & chorizo', '2018-01-24', '2018-01-27 17:05:13.195', 1, 1, '<ul>
<li>100g Puy-linzen</li>
<li>2 eetl. olijfolie</li>
<li>60g chorizo, fijngehakt</li>
<li>1 ui, fijngeschneden</li>
<li>2 teentjes knoflook, uitegeperst</li>
<li>3 theel. gemalen komijn</li>
<li>2 theel. gemalen koriander</li>
<li>&frac12; theel. kaneel</li>
<li>&frac12; theel. gedroogde chilivlokken</li>
<li>4 tomaten, gepeld, vruchtvlees fijngehakt</li>
<li>1 blik van 400 g kikkererwten, afgespoeld en uitgelekt</li>
<li>1 eetl. tomatenpuree</li>
<li>1&frac12; liter groenten- of kippenbouillon</li>
<li>zout en versgemalen zwarte peper</li>
<li>sap van ca. &frac12; citroen, naar smaak</li>
</ul>', '<p>Deze grove, gezonde soep bevat veel voedingsvezel en samengestelde koolhydraten die zorgen voor langzaam-vrijkomende energie waardoor u langer actief bent</p>', '', '<p>Doe de linzen in een grote pan, overgiet ze royaal met kokend water en laat ze in circa 20 minuten net gaar koken. Laat ze goed uitlekken.</p>
<p>Verhit de olie in de gewassen pan en fruit de chorizo, ui en knoflook 4 minuten op halfhoog vuur. Roer er gemalen komijn en koriander, kaneel en chilipeper door en daarna de tomaten, kikkererwten, tomatenpuree en bouillon. Breng aan de kook, draai het vuur laag, zet het deksel op de pan en laat de soep 15 minuten pruttelen.</p>
<p>Breng hem op smaak met zout, peper en citroensap. Schep de soep in diepe borden of kommen en dien hem op.</p>', true);
INSERT INTO public.recipes VALUES (11, 'Marokkaanse Harira', '2018-01-29', '2018-01-29 20:43:38.611', 1, 1, '<ul>
<li>100g Puy-linzen</li>
<li>2 eetl. olijfolie</li>
<li>1 ui, fijngesneden</li>
<li>2 teentjes knoflook, uitgeperst</li>
<li>&frac12; theel. gemberpoeder</li>
<li>2 theel. kaneel</li>
<li>&frac12; theel. geelwortelpoeder</li>
<li>1 theel. harissa</li>
<li>1&frac14; liter kippenbouillon</li>
<li>1 blik van 400g tomatenblokjes</li>
<li>1 eetl. tomatenpuree</li>
<li>1 blik van 400g kikkererwten, afgespoeld en uitgelekt</li>
<li>2 kipfilets, in reepjes</li>
<li>Sap van &frac14;-&frac12; citroen</li>
<li>Zout en&nbsp;versgemalen zwarte peper</li>
<li>Handvol fijngesneden koriander, om te bestrooien</li>
</ul>', '<p>Er bestaan talloze varianten van deze soep die tijdens de 30 dagen durende Ramadan elke avond wordt opgediend. Dit recept met linzen en kip us gekruid maar niet al te heet.</p>', '', '<p>Kook de linzen in een pan met ruim kokend water in cirka 25 minuten gaar. Giet ze af en zet opzij. Verhit de olie in een grote pan en smoor ui en knoflook 5 minuten. Roer er gemberpoeder, kaneel, geelwortel en harissa door, gevolgd door de bouillon. Voeg de blokjes tomaat, tomatenpuree, kikkererwten en linzen toe.</p>
<p>Breng de soep aan de kook, draai het vuur laag en zet het deksel op de pan. Doe de kip erin en laat de soep 5 tot 10 minuten zachtjes koken tot de kip gaar is. Roer er citroensap, zout en peper naar smaak door en dien de soep op, bestrooid met koriander.</p>', true);
INSERT INTO public.recipes VALUES (12, 'Pastinaaksoup met kerrie', '2018-01-29', '2018-01-29 20:52:38.447', 1, 1, '<ul>
<li>2 eetl. zonnebloemolie</li>
<li>3 teentjes knoflook, uitgeperst</li>
<li>1 ui, fijngesneden</li>
<li>2 groene chilipepers, vruchtvless fijngehakt</li>
<li>1 theel. gemalen komijn</li>
<li>1 theel. gemalen koriander</li>
<li>&frac12; theel. gemberpoeder</li>
<li>&frac12; theel. geelwortelpoeder</li>
<li>5 pastinaken, geschild en fijngehakt</li>
<li>1&frac14; liter groente- of kippenbouillon</li>
<li>Sap van ca. &frac12; citroen, naar smaak</li>
<li>Zout en versgemalen zwarte peper</li>
<li>Yoghurt en punten vers baanbrood, voor erbij</li>
<li>1 eetl. fijngesneden munt, om te bestrooien</li>
</ul>', '<p>Deze pittige, verwarmende soep is een klassieker. Zoete, geurige pastinaken zijn een goede combinatie met de Indiase specerijen. U kunt er eleke soort brood bij geven, maar stukjes naan passen goed bij de Indiase smaak.</p>', '', '<p>Verhit de olie in een grote pan en smoor knoflook, ui en chilipeper 4 minuten. Roer de gemalen komijn en koriander, het gember- en geelwortelpoeder en de pastinaken erdoor en voeg de bouillon toe. Breng de soep aan de kook en draai het vuur laag. Zet het deksel op de pan en laat de soep circa 20 minuten zachtjes koken tot de pastinaak gaar is.</p>
<p>Pureer de soep in een foodprocessor of een blender glad. Roer er citroensap, zout en peper naar smaak door. Dien de soep op met een dor yoghurt, bestrooid met munt en geef de partjes naan erbij.</p>', true);
INSERT INTO public.recipes VALUES (13, 'De nemmeste boller', '2018-02-11', '2018-02-11 17:36:56.848', 1, 1, '<p>50 gram G&aelig;r<br />8 spsk. Vand<br />3 dl. Letm&aelig;lk<br />6 tsk. Sukker<br />0.75 tsk. Salt<br />0.5 dl. Olie<br />800 gram Hvedemel<br /> <br /> Pensling:<br />1 &AElig;g</p>', '', '', '<p>Opl&oslash;s g&aelig;ren i lunkent vand fra den varme hane (30 grader C.) Tils&aelig;t det &oslash;vrige, men kun halvdelen af melet. &AElig;lt dejen sammen og &aelig;lt efterh&aring;nden mere af melet i, til dejen slipper.</p>
<p>Tril dejen til en p&oslash;lse, og sk&aelig;r i passende stk. Form til kugler og stil dem p&aring; en bekl&aelig;dt plade. D&aelig;k med et rent h&aring;ndkl&aelig;de, stil til h&aelig;vning i 10-20 min.</p>
<p>Pensel med &aelig;g og bages 10-12 min. ved 225 grader C almindelig ovn.</p>
<p>Tips:</p>
<p>Kom evt. kardemomme el. vanllie i, efter smag.</p>', false);
INSERT INTO public.recipes VALUES (14, 'Pikante wortelsoep', '2018-02-11', '2018-02-16 14:30:34.327', 1, 1, '<ul>
<li>2 eetl. zonnebloemolie</li>
<li>1 ui. fijngesneden</li>
<li>3 teentjes knoflook, uitgeperst</li>
<li>2 theel. gemalen komiin</li>
<li>1 theel. gemalen koriander</li>
<li>&frac12; theel. gemberpoeder</li>
<li>1 theel. paprikapoeder</li>
<li>Flinke snuf cayennepeper</li>
<li>1 kleine aardappel, in blokjes</li>
<li>500g wortelen, in schrijfjes</li>
<li>1&frac14; liter groente- of kippenbouillon</li>
<li>Sap van 1 sinaasappel</li>
<li>1-1&frac12; eetl. rode-wijnazijn</li>
<li>Zout en versgemalen zwarte peper</li>
<li>Handvol fijngesneden koriander</li>
</ul>', '<p>Deze pikante&nbsp;gekruide wortelsoep met Marokkaanse kruiden is een heerlijke maaltijd met puntjes geroosterd pitabrood of&nbsp;Midden-Oosters plat brood, of geef hem zo als hapje tussendoor.</p>', '', '', true);
INSERT INTO public.recipes VALUES (17, 'Thomas Test Recipe', '2018-02-16', '2018-03-06 10:35:00.905', 1, 1, '', '', 'A0907ED6-57E9-42C5-9AB8ADF697583C6F', '', false);
INSERT INTO public.recipes VALUES (18, 'The Most Wonderful Vegan Chocolate Chip Cookies Ever', '2018-02-21', '2018-02-21 13:08:20.649', 2, 2, '<ul>
<li>1/2 cup coconut oil, solid (be sure it is not melted at all)</li>
<li>1 and 1/4 cups light brown sugar, packed (I only used 1 cup, and I used palm sugar. With palm sugar the cookies will be darker in colour, but still delicious)</li>
<li>2 teaspoons vanilla extract</li>
<li>1/4 cup coconut milk (I like to use the thicker Thai variety, but any coconut milk will work)</li>
<li>1/4 cup unsweetened applesauce</li>
<li>2 and 1/4 cups all-purpose flour (be sure not to pack your flour)</li>
<li>1 teaspoon baking soda</li>
<li>1/2 teaspoon salt</li>
<li>2 cups chocolate chips (use vegan chocolate chips if vegan), divided (I used maybe a cup, but you can adjust depending how much chocolate you like)</li>
<li>Flaky sea salt, optional</li>
</ul>', '<p>Original recipe can be found here with more pictures&nbsp;https://bakerbynature.com/the-most-wonderful-vegan-chocolate-chip-cookies-ever/</p>', '108B99CB-EE70-4288-A3E699F598A06B89', '<p>Preheat oven to 375 degrees (F) / 190 degrees celsius. Line a large baking sheet with parchment paper; set aside.</p>
<p><br />In a large bowl whisk together the coconut oil, brown sugar, and vanilla, beating until well combined. Add in the coconut milk and applesauce and whisk until well combined; set aside. In a separate bowl combine the flour, baking soda, and salt; whisk well to combine.</p>
<p><br />Add the dry ingredients into the wet mixture and, using a wooden spoon or very sturdy spatula, stir until ingredients are combined. The batter will be very thick! Fold in 1 and 3/4 cups of the chocolate chips.</p>
<p><br />Scoop three tablespoon sized mounds of dough onto the prepared cookie sheet, leaving a few inches between each cookies for spreading. Bake for 9 to 10 minutes, or until the edges are golden and the centers have set. Press remaining chocolate chips on top of warm cookies, and sprinkle with sea salt, if using. Cool cookies on the baking sheet for 15 minutes before transferring them to a cooling rack.</p>
<p>&nbsp;</p>
<p><strong>Note:</strong></p>
<p>If the dough appears too sticky, add a little more flour, one tablespoon at a time; if the dough appears too dry, add a tablespoon of coconut milk.</p>', true);
INSERT INTO public.recipes VALUES (20, 'Loaded quinoa salad', '2018-02-25', '2018-02-25 09:25:50.721', 2, 2, '<ul>
<li>3 dl of quinoa</li>
<li>6 dl water</li>
<li>2 big leaves of kale (<em>boerenkool</em>) Tip: did you know that kale is the best after the first frost?</li>
<li>1/2 dl of mint leaves</li>
<li>2 big oranges</li>
<li>1/2 dl chopped almods</li>
<li>seeds of 1 pomegranate (cut pomegranate in half, fill a bowl with water and separate the seeds from the flesh under water, no mess all over your kitchen, yay!)</li>
<li>1/2 dl dried or fresh cranberries</li>
<li>olive oil</li>
<li>some salt</li>
</ul>', '<p>This salad recipe is actually from Christmas themed book, originally named Christmas salad, but you can make this anytime. Of course, it is best when kale, citrus fruit and pomegranata are in season, so winter time is best to make it.&nbsp;</p>
<p>&nbsp;</p>', '115DEDFC-CE88-422E-A0630CB357682491', '<p>Cook the quinoa, usually you use double the amount of water to quinoa, but do follow the instructions on your quinoa if it is different. After cooking the quinoa, cool it in a bowl.</p>
<p>Chop the kale, but leave out the hard stalks. Add that into the bowl with the cooled of quinoa.</p>
<p>Add the chopped mint, peeled and chopped oranges (I prefer to segment my oranges, but you can do what you like), almonds, pomegranate seeds and cranberries. Add olive oil and salt. Mix. Keep in the fridge till serving.</p>
<p>&nbsp;</p>
<p>Tip: you can prepare this salad in advance, but then leave out the almods and add them just before serving.</p>', true);
INSERT INTO public.recipes VALUES (19, 'Chickpea curry', '2018-02-22', '2018-02-22 22:13:15.575', 2, 2, '<ul>
<li>rice (I usually use brown rice, but you can use what you like)</li>
<li>2 medium onions</li>
<li>2 tbsp olive oil</li>
<li>3 cloves garlic</li>
<li>&frac12; lime (or more, depends how much citrus you like, I sometimes even add a whole one. And seriously, what are you really going to do with the other half? 😉 )</li>
<li>1-2 tbsp of your favourite curry paste</li>
<li>1 can coconut milk (1 can = 1.5 cups )</li>
<li>1 can chickpeas, drained and rinsed (1 can = ca. 400g with liquid)</li>
<li>1-2 tbsp soy sauce or tamari soy sauce</li>
<li>2-3 medium tomatoes/ handful cherry tomatoes, chopped. The sweeter the better 😉</li>
<li>1 cup basil leaves (this is optional, if you don''t have use for the rest of the basil, I would leave it out)</li>
<li>Additional: I like to add some blanced spinach in my curry too, so just blanch a few big handfuls, and add that to the curry in the end just to warm it through</li>
</ul>', '<p>Delicious, easy to make curry!</p>', '21A21091-499E-4F3E-A9260D078870D142', '<p>Start cooking the rice, and while it cooks, prepare your curry. Though, keep in mind that you might want to cook the curry longer, so if the type of rice cooks very fast, make the curry first and worry about cooking the rice later.</p>
<p><br />Chop the onions, garlic, basil and juice the lime.</p>
<p><br />Put the oil and onions into a large pan and cook on a low-medium heat until the onions start to soften and turn clear, about 5 minutes. Add the garlic for a further 1 minute.</p>
<p><br />Add 1 tbsp curry paste and the coconut milk, stirring until the curry is dissolved. Add another pinch of salt. Taste test - if you&rsquo;d like your curry a little stronger then add another tbsp.</p>
<p><br />Throw in the chickpeas and soy sauce, and cook on a medium heat for around 5 minutes, bringing the curry to a boil. If it starts to burn, reduce heat immediately. (To develop more flavour, add some water and let it cook slowly for 20-30 mins. If you don''t want to wait, just skip this step.)</p>
<p><br />Add the chopped tomatoes, chopped basil, lime juice and gently simmer the curry for another 2 minutes. Taste test again, and if desired add a second tbsp soy sauce. Give it another stir.</p>
<p><br />Serve!</p>', true);
INSERT INTO public.recipes VALUES (21, 'Spinach pancakes', '2018-03-05', '2018-03-06 10:39:00.287', 2, 2, '<ul>
<li>150 grams of frozen spinach</li>
<li>2,5 dl flour</li>
<li>1 dl oats</li>
<li>1/4 - 0,5 teaspoons of salt</li>
<li>1 teaspoon of baking powder</li>
<li>4,5 dl of soy milk or oat milk&nbsp;</li>
<li>2 teaspoon of neutral oil</li>
<li>lingonberry jam&nbsp;</li>
</ul>', '<p>Green pancakes? Yes, we eat green pancakes in Finland.</p>', '2AAC5FBF-77CD-4472-8D9D4DB86B2B9C58', '<ol>
<li>Melt the spinach (if you remember, you can just defrost it in the fridge, or just put it in a pan with a bit of water and melt it)</li>
<li>Mix flour, oats, baking powder and salt.</li>
<li>Add milk, oil and spinach. Stir.</li>
<li>Let it rest for 15 mins.</li>
<li>Bake!</li>
</ol>
<p>I love to pake these on an old cast iron pan, so easy and they look cute too :)&nbsp;</p>
<p>&nbsp;</p>', true);
INSERT INTO public.recipes VALUES (23, 'Leek and potato soup', '2018-03-11', '2018-03-11 16:04:37.566', 2, 2, '<ul>
<li>1 tbsp vegetable oil</li>
<li>1 onion, sliced</li>
<li>225grams/8oz potatoes, cubed</li>
<li>2 medium leeks, sliced</li>
<li>1.2 litres/2 pints vegetable stock (or till about the hight that it covers the leek and potatos in the pan)</li>
<li>150ml/5fl oz double cream or cr&egrave;me fra&icirc;che</li>
<li>salt and freshly ground black pepper</li>
</ul>', '<p>A smooth, creamy vegetable soup that''s full of flavour.&nbsp;Serve with bread or a salad.</p>', '353DA29D-67C3-4D16-B1206828370BEFFF', '<ol>
<li>Heat the oil in a large pan and add the onions, potatoes and leeks. Cook for 3-4 minutes until starting to soften.</li>
<li>Add the vegetable stock and bring to the boil. Season well and simmer until the vegetables are tender.</li>
<li>Whizz with a hand blender or in a blender until smooth. Reheat in a clean pan, stir in the cream or cr&egrave;me fra&icirc;che, heat through and serve.</li>
</ol>', true);
INSERT INTO public.recipes VALUES (24, 'Grilled halloumi, spinach & toasted seed salad', '2018-08-30', '2018-08-30 19:24:53.49', 1, 1, '<ul>
<li>1 handful sunflower or pumpkin seeds</li>
<li>2 carrots, peeled</li>
<li>1 bulb fennel, trimmed and halved</li>
<li>2 large handfuls baby spinach leaves, washed and spun dry</li>
<li>100 g fresh peas, podded</li>
<li>250 g halloumi cheese, cut into 1cm slices</li>
<li>1 lemon</li>
<li>extra virgin olive oil</li>
<li>sea salt</li>
<li>freshly ground black pepper</li>
</ul>', '<p>Grilled halloumi, spinach &amp; toasted seed salad - With fresh peas and crunchy fennel</p>
<p>This Mediterranean-style halloumi salad feels like a treat but is super quick and easy to rustle up!</p>
<p>Serves 2</p>
<p>15m</p>
<p>Super easy</p>', '933DB7AC-3265-4789-938DF1439BF61E64', '<p>Toast the seeds in a dry frying pan over a high heat, moving them around the pan from time to time so they don''t burn. This will only take a couple of minutes. Put to one side. Using a speed peeler, cut the carrots and the fennel bulb into thin ribbons. Place in a bowl with the spinach and peas.</p>
<p>Place your halloumi in a really hot frying or griddle pan, and give the slices a minute or so on each side. The cheese will soften slightly as it cooks. Dress your salad with a good squeeze of lemon juice, about twice as much olive oil, and a pinch of salt and pepper. Toss to coat everything in the dressing. Have a taste and add some more seasoning or lemon juice if you like.</p>
<p>To serve, tear the pieces of halloumi over the salad and sprinkle with the toasted seeds.</p>
<p>Tip: If you can''t get hold of any halloumi, tear cold, cream mozzarella over the top instead.</p>', true);
INSERT INTO public.recipes VALUES (25, 'STUFFED BELL PEPPERS WITH QUINOA', '2018-10-13', '2018-10-13 13:18:46.429', 1, 1, '<p><em></em>4 bell peppers (halfed length wise, ribs removed)<br />1/2 cup quinoa<br />1/2 pound ground turkey (or ground beef)<br />1 small onion<br />14 ounces fire roasted tomatoes (1 can, plain is fine too)<br />7 ounces diced green chili (1 can)<br />14 ounces black beans (1 can, drained and rinsed)<br />1 Tablespoon taco seasoning<br />1/2 Tablespoon cumin<br />1/2 Tablespoon olive oil<br />1/2 cup mozzarella shredded cheese<br />3/4 cup water</p>', '', 'ABD61F9A-2B05-48BF-A047057276903803', '<p>Heat olive oil in a large saucepan. Add onion and cook until translucent ( about 3 minutes). Add in meat and cook until browned. Drain any excess grease.</p>
<p><br />Add in black beans, tomatoes, green chilies, water, quinoa, cumin, taco seasoning, salt and pepper if desired. Cover and bring to a boil. Reduce heat to medium/low and simmer for 10-15 minutes or until quinoa is done.</p>
<p><br />Heat oven to 375. Place peppers in 13 x 9 baking dish. Spoon in filling and top with grated cheese. Cover pan with foil and bake for 40 minutes.</p>
<p><br />Remove from oven and serve with sour cream or salsa (optional). Enjoy!</p>', true);
INSERT INTO public.recipes VALUES (22, 'Chicken, Apple, Sweet Potato, and Brussels Sprouts Skillet', '2018-03-10', '2019-08-19 14:14:53.533', 1, 1, '<ul>
<li>1 tablespoon olive oil</li>
<li>1 pound boneless, skinless chicken breasts, cut into 1/2-inch | 1.27-cm cubes</li>
<li>1 teaspoon kosher salt, divided</li>
<li>1/2 teaspoon black pepper</li>
<li>2 slices thick-cut bacon, chopped</li>
<li>3 cups Brussels sprouts, trimmed and quartered (about 3/4 pounds | 340g)</li>
<li>1 medium sweet potato, peeled and cut into 1/2 inch cubes&nbsp;| 1.27-cm (about 8 ounces | 230g)</li>
<li>1 medium onion, chopped</li>
<li>2 Granny Smith apples, peeled and cut into 3/4-inch | 2cm cubes</li>
<li>4 cloves of garlic, minced (about 2 teaspoons)</li>
<li>2 teaspoons chopped fresh thyme or 1/2 teaspoon dried thyme</li>
<li>1 teaspoon ground cinnamon</li>
<li>1 cup reduced-sodium chicken broth, divided</li>
</ul>', '<p>With sweet potatoes, apples, Brussels sprouts and bacon, this healthy Paleo and Whole30 approved chicken skillet is packed with flavor and delivers every food group in one pan! <strong>Serves 4</strong></p>', 'D6FA97E4-D912-4C28-82687CCCCCAB06AF', '<ol>
<li>Heat the olive in a large, nonstick or cast iron skillet over medium high, until hot and shimmering. Add the chicken, 1/2 teaspoon kosher salt, and black pepper. Cook until lightly browned and cooked through, about 5 minutes. Transfer to plate lined with paper towels.<br /><br /></li>
<li>Reduce skillet heat to medium low. Add the chopped bacon and cook until crisp and brown and the fat has rendered, about 8 minutes. With a slotted spoon, transfer the bacon to a paper towel-lined plate. Discard all but 1&frac12;&nbsp;tablespoons of bacon fat from the pan.<br /><br /></li>
<li>Increase skillet heat back to medium high. Add Brussels sprouts, sweet potato, onion, and remaining 1/2 teaspoon salt. Cook, stirring occasionally, until crisp-tender and the onions are beginning to look translucent, about 10 minutes.<br /><br /></li>
<li>Stir in the apples, garlic, thyme, and cinnamon. Cook 30 seconds, pour in 1/2 cup of the broth. Cook until heated through, about 2 minutes. Stir in reserved bacon and serve warm.</li>
</ol>', true);
INSERT INTO public.recipes VALUES (10, 'Pittige kikkererwtensoep met citroen', '2018-01-27', '2019-12-13 10:14:47.679', 1, 1, '<ul>
<li>2 eetl. olijfolie</li>
<li>1 ui, fijngesneden</li>
<li>2 teentjes knoflook, uitegeperst</li>
<li>2 theel. gemalen komijn</li>
<li>1 theel. kaneel</li>
<li>&frac14; theel. gemberpoeder</li>
<li>2 blikken van 400g kikkererwten</li>
<li>450 g rijpe tomaten, gepeld en fijngehakt</li>
<li>1 liter groeten- of kippenbouillon</li>
<li>2 eetl. fijngesneden peterselie</li>
<li>Sap van ca. &frac12; citroen, naar smaak</li>
<li>Zout en versgemalen zwarte peper</li>
</ul>', '<p>Deze verwarmende, geurige soep is het hele jaar door verrukkelijk. Gebruikt een blik tomatenblokjes als de verse niet erg aromatisch zijn.</p>', '', '<p>Verhit de olie in een grote pan en smoor ui en knoflook 4 minuten. Voeg de gemalen komijn en kaneel, het gemberpoeder, de helft van de kikkererwten, de tomaten en 8 dl bouillon toe. Breng aan de kook. Draai het vuur laag, zet het deksel op de pan en laat de soep circa 5 minuten zachtjes koken.</p>
<p>Pureer intussen de overige kikkererwten met de achtergehouden bouillon in een foodprocessor of een blender glad. Roer de puree door de soep, gevolgd door de peterselie. Breng de soep op smaak met zout, peper en citroensap en dien hem op.</p>', true);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: usersettings; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usersettings VALUES (1, 'full', 'CreatedOn', false, false, false, false, false, false);
INSERT INTO public.usersettings VALUES (2, 'full', 'CreatedOn', false, false, false, false, false, false);
INSERT INTO public.usersettings VALUES (3, 'full', 'CreatedOn', false, false, false, false, false, false);
INSERT INTO public.usersettings VALUES (4, 'full', 'CreatedOn', false, false, false, false, false, false);
INSERT INTO public.usersettings VALUES (5, 'full', 'CreatedOn', false, false, false, false, false, false);
INSERT INTO public.usersettings VALUES (6, 'full', 'CreatedOn', false, false, false, false, false, false);
INSERT INTO public.usersettings VALUES (7, 'full', 'CreatedOn', false, false, false, false, false, false);
INSERT INTO public.usersettings VALUES (8, 'full', 'CreatedOn', false, false, false, false, false, false);


--
-- Name: comments_commentid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_commentid_seq', 1, false);


--
-- Name: recipes_recipeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recipes_recipeid_seq', 25, true);


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_userid_seq', 9, true);


--
-- PostgreSQL database dump complete
--

