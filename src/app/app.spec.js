import app from './app.module';

describe('app', () => {

  describe('Main', () => {
    let ctrl;

    beforeEach(() => {
      angular.mock.module(app);

      angular.mock.inject(($controller) => {
        ctrl = $controller('appController', {});
      });
    });

    it('should contain the starter url', () => {
      expect(ctrl.url).toBe('a-default-url');
    });
  });
});