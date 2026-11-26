# Amazon ElastiCache

The proposed CMS cache would reduce repeated Aurora reads when shoppers browse a store’s catalog. Each entry would belong to one store and SKU. For example, `catalog:{store_id}:{sku}` keeps two stores’ prices for the same product independent.

On a cache miss, the API would read the item from Aurora and cache the result with a short expiry. After a store operator commits a price or assortment change, the service would invalidate the affected entry. If the cache is unavailable, the API can read from Aurora directly.

At checkout, the API must recheck the current price and reserve available stock in Aurora. A cached listing can be stale between browsing and checkout.
