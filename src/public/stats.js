(function () {
  if (window.__STATS_LOADED__) return;
  window.__STATS_LOADED__ = true;

  const endpoint =
    location.hostname === 'localhost'
      ? 'http://localhost:3100/api/stats'
      : '/api/stats';

  function sendStats(path) {
    fetch(endpoint, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        uid: localStorage.getItem('uid') || crypto.randomUUID(),
        path,
        ts: Date.now()
      })
    });
  }

  // Sauvegarde l’UID si pas encore fait
  if (!localStorage.getItem('uid')) {
    localStorage.setItem('uid', crypto.randomUUID());
  }

  // Page load
  sendStats(location.pathname);

  // Navigations internes (Astro recharge la page → pas besoin de pushState)
  window.addEventListener('popstate', () => {
    sendStats(location.pathname);
  });
})();
