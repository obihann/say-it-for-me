var should = require('should'); 
var assert = require('assert');
var request = require('supertest');  
var app = require ('../bin/app.js');

describe('Routing', function() {
    describe('Ipsum', function() {
    var body = {};       
    it('should correctly return lori ipsum', function(done){
        request(app)
            .get('/ipsum')
            .expect(200)
            .end(function (err, res) {
                should.not.exist(err);
                done();
            });
        });
    });

    describe('bacon', function() {
    var body = {};       
    it('should correctly return bacon ipsum', function(done){
        request(app)
            .get('/bacon')
            .expect(200)
            .end(function (err, res) {
                should.not.exist(err);
                done();
            });
        });
    });
});
