const MenuItem = require('../models/MenuItem');
const Restaurant = require('../models/Restaurant');

// Get menu by restaurant ID
exports.getMenuByRestaurant = async (req, res) => {
  try {
    const { restaurantId } = req.params;

    const menu = await MenuItem.find({ restaurant: restaurantId, available: true })
      .select('name description category price discountPrice image available ingredients allergens vegetarian vegan spicy rating reviewCount');

    res.json(menu);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get menu items by category
exports.getByCategory = async (req, res) => {
  try {
    const { restaurantId, category } = req.params;

    const items = await MenuItem.find({ restaurant: restaurantId, category, available: true })
      .select('name description price discountPrice image ingredients vegetarian vegan spicy rating reviewCount');

    res.json(items);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get menu item by ID
exports.getMenuItemById = async (req, res) => {
  try {
    const item = await MenuItem.findById(req.params.id).populate('restaurant', 'name');

    if (!item) {
      return res.status(404).json({ message: 'Menu item not found' });
    }

    res.json(item);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Create menu item
exports.createMenuItem = async (req, res) => {
  try {
    const { name, description, category, price, discountPrice, restaurant, image, ingredients, allergens, vegetarian, vegan, spicy } = req.body;

    // Check if restaurant exists
    const restaurantExists = await Restaurant.findById(restaurant);
    if (!restaurantExists) {
      return res.status(404).json({ message: 'Restaurant not found' });
    }

    const menuItem = new MenuItem({
      name,
      description,
      category,
      price,
      discountPrice,
      restaurant,
      image,
      ingredients,
      allergens,
      vegetarian,
      vegan,
      spicy
    });

    await menuItem.save();

    // Add item to restaurant's menu
    await Restaurant.findByIdAndUpdate(restaurant, {
      $push: { menu: menuItem._id }
    });

    res.status(201).json({
      message: 'Menu item created successfully',
      menuItem
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Update menu item
exports.updateMenuItem = async (req, res) => {
  try {
    let item = await MenuItem.findById(req.params.id);

    if (!item) {
      return res.status(404).json({ message: 'Menu item not found' });
    }

    Object.assign(item, req.body);
    await item.save();

    res.json({
      message: 'Menu item updated successfully',
      item
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Search menu items
exports.searchMenuItems = async (req, res) => {
  try {
    const { query, restaurantId, vegetarian, vegan, maxPrice } = req.query;

    let filter = { available: true };

    if (restaurantId) {
      filter.restaurant = restaurantId;
    }

    if (query) {
      filter.$or = [
        { name: { $regex: query, $options: 'i' } },
        { description: { $regex: query, $options: 'i' } }
      ];
    }

    if (vegetarian === 'true') {
      filter.vegetarian = true;
    }

    if (vegan === 'true') {
      filter.vegan = true;
    }

    if (maxPrice) {
      filter.price = { $lte: parseFloat(maxPrice) };
    }

    const items = await MenuItem.find(filter)
      .select('name description category price discountPrice image vegetarian vegan spicy rating reviewCount')
      .limit(20);

    res.json(items);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get recommended items
exports.getRecommended = async (req, res) => {
  try {
    const { restaurantId } = req.params;

    const items = await MenuItem.find({ restaurant: restaurantId, available: true })
      .sort({ rating: -1 })
      .limit(10)
      .select('name description price discountPrice image rating reviewCount');

    res.json(items);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
