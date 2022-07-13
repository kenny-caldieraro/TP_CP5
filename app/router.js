const express = require('express');
const cardController = require('./controllers/cardController');
const router = express.Router();
const listController = require('./controllers/listController');
const tagController = require('./controllers/tagController');

// List
router
  .route('/lists')
  .get(listController.getAllLists)
  .post(listController.createList);

router
  .route('/lists/:id')
  .get(listController.getOneList)
  .patch(listController.modifyList)
  .delete(listController.deleteList);

// Card
router.get('/lists/:id/cards', cardController.getAllCardsFromList);
router.post('/cards', cardController.createCard);

router
  .route('/cards/:id')
  .get(cardController.getOneCard)
  .patch(cardController.modifyCard)
  .delete(cardController.deleteCard);

// Tag
router
  .route('/tags')
  .get(tagController.getAllTags)
  .post(tagController.createTag);

router
  .route('/tags/:id')
  .patch(tagController.modifyTag)
  .delete(tagController.deleteTag);

router.post('/cards/:id/tag', tagController.addTagToCard);
router.delete('/cards/:card_id/tag/:tag_id', tagController.removeTagFromCard);

module.exports = router;
