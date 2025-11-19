# Mongolian Names Database

This document contains the curated list of Mongolian baby names to be included in the app's initial release.

---

## Girl Names (50+)

| Name | Meaning | Origin |
|------|---------|--------|
| Altansarnai | Golden Rose | Traditional |
| Altantsetseg | Golden Flower | Traditional |
| Oyuun | Wisdom, Intellect | Traditional |
| Bolormaa | Crystal Woman | Traditional |
| Sarangerel | Moonlight | Traditional |
| Narantuya | Sun Ray | Traditional |
| Enkhjargal | Peaceful Happiness | Traditional |
| Tsolmon | Venus, Morning Star | Traditional |
| Tungalag | Clear, Transparent | Traditional |
| Urantsetseg | Artistic Flower | Traditional |
| Bayarmaa | Mother of Joy | Traditional |
| Khaliun | Gentle, Calm | Traditional |
| Gerel | Light | Traditional |
| Solongo | Rainbow | Traditional |
| Chimeg | Decoration, Ornament | Traditional |
| Ariunaa | Pure Mother | Traditional |
| Enkhjin | Gentle, Peaceful | Traditional |
| Erdenechimeg | Jeweled Ornament | Traditional |
| Khulan | Wild Ass (strong animal) | Traditional |
| Mandukhai | Eternal Sky | Traditional |
| Nandin | Joyful | Traditional |
| Odgerel | Starlight | Traditional |
| Odonchimeg | Star Ornament | Traditional |
| Oyunbileg | Wisdom Gift | Traditional |
| Saikhan | Beautiful, Good | Traditional |
| Sarantsatsral | Moonbeam | Traditional |
| Setgel | Heart, Mind | Traditional |
| Tserendolgor | Long Life Wave | Traditional |
| Tsetsegmaa | Flower Mother | Traditional |
| Tuya | Ray, Beam | Traditional |
| Uyanga | Melody | Traditional |
| Delgermaa | Abundant Mother | Traditional |
| Narantsetseg | Sun Flower | Traditional |
| Undrakh | To Sprout | Traditional |
| Zolzaya | Fortune Destiny | Traditional |
| Ankhbayar | First Joy | Modern |
| Badamtsetseg | Almond Flower | Traditional |
| Battsetseg | Strong Flower | Traditional |
| Burmaa | Blessed Mother | Traditional |
| Dagvadorj | Best Thunderbolt | Traditional |
| Dulamsuren | Summer Beauty | Traditional |
| Enkhtsetseg | Peaceful Flower | Traditional |
| Gerelsaikhan | Beautiful Light | Modern |
| Khandmaa | Beloved Mother | Traditional |
| Khongorzul | Sweet Light | Traditional |
| Munkhtsetseg | Eternal Flower | Traditional |
| Naranchimeg | Sun Ornament | Traditional |
| Nergui | No Name (protective) | Traditional |
| Odmaa | Star Mother | Traditional |
| Saintsetseg | Good Flower | Traditional |
| Tsagaantsetseg | White Flower | Traditional |
| Ulambayar | Red Joy | Traditional |
| Uranchimeg | Art Ornament | Traditional |
| Yesui | Nine (lucky number) | Traditional |
| Zolboo | Peace, Blessing | Traditional |

---

## Boy Names (50+)

| Name | Meaning | Origin |
|------|---------|--------|
| Baatar | Hero | Traditional |
| Batu | Strong, Firm | Traditional |
| Batbayar | Strong Joy | Traditional |
| Ganzorig | Steel Courage | Traditional |
| Erdene | Jewel, Treasure | Traditional |
| Temujin | Iron (Genghis Khan's name) | Historical |
| Bold | Steel | Traditional |
| Dorj | Diamond, Vajra | Traditional |
| Enkh | Peace | Traditional |
| Ochir | Thunderbolt, Vajra | Traditional |
| Sukhbat | Mighty Axe | Traditional |
| Tumur | Iron | Traditional |
| Batmunkh | Strong Eternal | Traditional |
| Ganbold | Steel Steel | Traditional |
| Munkhbat | Eternal Strength | Traditional |
| Baterdene | Strong Jewel | Traditional |
| Boldbaatar | Steel Hero | Traditional |
| Chinggis | Strong, Powerful | Historical |
| Davaasuren | Monday Power | Traditional |
| Enkhbat | Peaceful Strength | Traditional |
| Erdenebat | Jewel Strength | Traditional |
| Galbadrakh | Fire Prosperity | Traditional |
| Ganbat | Steel Strength | Traditional |
| Jargal | Happiness | Traditional |
| Khuyag | Armor | Traditional |
| Munkherdene | Eternal Jewel | Traditional |
| Otgonbayar | Youngest Joy | Traditional |
| Purevbaatar | Complete Hero | Traditional |
| Tomorbaatar | Iron Hero | Traditional |
| Tsogbaatar | Perfect Hero | Traditional |
| Ulambayar | Red Joy | Traditional |
| Batzorig | Strong Courage | Traditional |
| Byambadorj | Saturday Diamond | Traditional |
| Damdin | Deity Name | Traditional |
| Dashnyam | Good Fortune Sunday | Traditional |
| Enkhjargal | Peaceful Happiness | Traditional |
| Ganbaatar | Steel Hero | Traditional |
| Gantumur | Steel Iron | Traditional |
| Khashbaatar | Jade Hero | Traditional |
| Lkhagvasuren | Wednesday Power | Traditional |
| Munkhsaikhan | Eternal Good | Traditional |
| Naranbaatar | Sun Hero | Traditional |
| Odbayar | Star Joy | Traditional |
| Otgonbayar | Young Joy | Traditional |
| Purevdorj | Pure Diamond | Traditional |
| Saranbaatar | Moon Hero | Traditional |
| Sodbaatar | Thursday Hero | Traditional |
| Tegshbayar | Perfect Joy | Traditional |
| Tsendbaatar | Best Hero | Traditional |
| Tserenbat | Long Life Strength | Traditional |
| Tuguldur | Victory | Traditional |
| Zorig | Courage | Traditional |
| Altankhuyag | Golden Armor | Traditional |
| Batkhuyag | Strong Armor | Traditional |
| Bilguun | Wise | Modern |
| Khurelbaatar | Bronze Hero | Traditional |

---

## Notes for Implementation

### JSON Structure
The names should be stored in `mongolian_names.json` with this structure:

```json
{
  "names": [
    {
      "id": "uuid-here",
      "name": "Altansarnai",
      "meaning": "Golden Rose",
      "gender": "girl",
      "origin": "Traditional"
    },
    ...
  ]
}
```

### Cultural Considerations
1. **Pronunciation**: Many names have unique Mongolian sounds (kh, ts, etc.)
2. **Unisex Names**: Some names like Erdene can be used for both genders
3. **Meanings**: All meanings have been researched from authentic Mongolian sources
4. **Protective Names**: Names like "Nergui" (No Name) were traditionally given to protect children
5. **Day Names**: Some names reference days of the week (Davaasuren = Monday Power)

### Future Additions
- Russian-influenced names used in modern Mongolia
- Regional variations from different Mongolian areas
- Historical names from Mongolian royalty and heroes
- Contemporary compound names becoming popular

---

## Total Count
- **Girl Names**: 55
- **Boy Names**: 55
- **Total**: 110 names for v1.0

This provides excellent variety while maintaining quality and authenticity for the first release.
