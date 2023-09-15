abstract class ShopStates{}

class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesDataState extends ShopStates{}
class ShopLoadingCategoriesDataState extends ShopStates{}
class ShopErrorCategoriesDataState extends ShopStates{}

class BannerChanged extends ShopStates{}